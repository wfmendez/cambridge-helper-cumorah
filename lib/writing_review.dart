import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WritingReviewException implements Exception {
  const WritingReviewException(this.message);
  final String message;
}

class WritingCriterionFeedback {
  const WritingCriterionFeedback(this.name, this.score, this.reason);
  final String name;
  final int score;
  final String reason;
}

class WritingCorrection {
  const WritingCorrection(this.original, this.replacement, this.explanation);
  final String original;
  final String replacement;
  final String explanation;
}

/// Whether the answer does what the task asked. Cambridge's Content scale
/// asks this before anything else, and so does the review screen: a learner
/// who answered a different question needs to hear that before any grammar.
enum TaskRelevance { onTask, partly, offTask }

enum PointStatus { covered, partly, missing }

class TaskPoint {
  const TaskPoint(this.point, this.status, this.evidence);
  final String point;
  final PointStatus status;

  /// A phrase copied from the answer that shows the point, or empty. The
  /// server drops any quotation that is not really in the answer.
  final String evidence;
}

/// How the answer could meet the task, built on the learner's own ideas.
/// Empty when the answer already does.
class TaskRedirect {
  const TaskRedirect(this.explanation, this.plan, this.opening);
  final String explanation;
  final List<String> plan;
  final String opening;
  bool get isEmpty => explanation.isEmpty && plan.isEmpty;
}

class TaskResponse {
  const TaskResponse(this.relevance, this.points, this.redirect);
  final TaskRelevance relevance;
  final List<TaskPoint> points;
  final TaskRedirect redirect;

  /// Null when it is missing or not understood. A server from before this
  /// existed, or one from after it changes, should cost the learner this one
  /// section — not the whole review.
  static TaskResponse? tryParse(dynamic json) {
    try {
      final relevance = switch (json['relevance']) {
        'on-task' => TaskRelevance.onTask,
        'partly' => TaskRelevance.partly,
        'off-task' => TaskRelevance.offTask,
        _ => throw const FormatException(),
      };
      final points = [
        for (final p in json['points'] as List)
          TaskPoint(p['point'] as String, switch (p['status']) {
            'covered' => PointStatus.covered,
            'partly' => PointStatus.partly,
            'missing' => PointStatus.missing,
            _ => throw const FormatException(),
          }, p['evidence'] as String),
      ];
      final r = json['redirect'];
      return TaskResponse(
        relevance,
        points,
        TaskRedirect(r['explanation'] as String, [
          for (final step in r['plan'] as List) step as String,
        ], r['opening'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}

class WritingFeedback {
  const WritingFeedback({
    this.taskResponse,
    required this.summary,
    required this.criteria,
    required this.strengths,
    required this.improvements,
    required this.corrections,
    required this.correctedText,
    required this.provider,
  });

  final TaskResponse? taskResponse;
  final String summary;
  final List<WritingCriterionFeedback> criteria;
  final List<String> strengths;
  final List<String> improvements;
  final List<WritingCorrection> corrections;
  final String correctedText;
  final String provider;
  int get total => criteria.fold(0, (total, item) => total + item.score);

  factory WritingFeedback.fromJson(Map<String, dynamic> json) {
    String text(dynamic value) {
      if (value is! String || value.trim().isEmpty) {
        throw const FormatException();
      }
      return value;
    }

    List<String> texts(dynamic value) => (value as List).map(text).toList();
    const names = [
      'Content',
      'Communicative Achievement',
      'Organisation',
      'Language',
    ];
    final criteria = (json['criteria'] as List).map((item) {
      final score = item['score'];
      if (score is! int || score < 0 || score > 5) {
        throw const FormatException();
      }
      return WritingCriterionFeedback(
        text(item['name']),
        score,
        text(item['reason']),
      );
    }).toList();
    if (criteria.length != 4 ||
        !listEquals(criteria.map((c) => c.name).toList(), names)) {
      throw const FormatException();
    }
    return WritingFeedback(
      taskResponse: TaskResponse.tryParse(json['taskResponse']),
      summary: text(json['summary']),
      criteria: criteria,
      strengths: texts(json['strengths']),
      improvements: texts(json['improvements']),
      corrections: (json['corrections'] as List)
          .map(
            (item) => WritingCorrection(
              text(item['original']),
              text(item['replacement']),
              text(item['explanation']),
            ),
          )
          .toList(),
      correctedText: text(json['correctedText']),
      provider: text(json['provider']),
    );
  }
}

class WritingReviewClient {
  WritingReviewClient({http.Client? client, Uri? endpoint})
    : _client = client ?? http.Client(),
      _endpoint =
          endpoint ??
          (kIsWeb
              ? Uri.base.resolve('/api/writing-review')
              : Uri.parse(
                  'https://cambridge-helper-cumorah.vercel.app/api/writing-review',
                ));

  final http.Client _client;
  final Uri _endpoint;

  Future<WritingFeedback> review(String taskId, String text) async {
    try {
      final response = await _client
          .post(
            _endpoint,
            headers: {'Content-Type': 'application/json', 'X-Cil-Review': '1'},
            body: jsonEncode({'taskId': taskId, 'text': text}),
          )
          .timeout(const Duration(seconds: 55));
      if (response.statusCode != 200) {
        // No mostrar HTML del proxy ni errores del proveedor al estudiante.
        throw WritingReviewException(switch (response.statusCode) {
          429 => 'Too many reviews. Please wait a few minutes and try again.',
          413 => 'Keep your answer under 800 words and 8,000 characters.',
          400 => 'Choose a task and write at least 30 words before requesting a review.',
          _ => 'Writing review is temporarily unavailable. Your draft is safe. Try again later.',
        });
      }
      return WritingFeedback.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } on WritingReviewException {
      rethrow;
    } on TimeoutException {
      throw const WritingReviewException(
        'The review took too long. Your draft is safe. Please try again.',
      );
    } on http.ClientException {
      throw const WritingReviewException(
        'Could not connect. Check your internet connection and try again. Your draft is safe.',
      );
    } catch (_) {
      throw const WritingReviewException(
        'The review could not be read. Your draft is safe. Please try again.',
      );
    }
  }

  void close() => _client.close();
}
