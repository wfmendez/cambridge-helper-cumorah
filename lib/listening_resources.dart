import 'cambridge.dart';

/// Free lessons hosted by their publisher. Audio and transcripts are not
/// bundled or redistributed. Direct lesson links checked on 30 September 2026.
class ListeningResource {
  const ListeningResource(this.level, this.title, this.slug, this.focus);
  final ExamLevel level;
  final String title;
  final String slug;
  final String focus;
  String get url =>
      'https://learnenglish.britishcouncil.org/free-resources/'
      'listening/${level.cefr.toLowerCase()}/$slug';
}

const listeningResources = <ListeningResource>[
  ListeningResource(
    ExamLevel.b1,
    'A phone call from a customer',
    'phone-call-customer',
    'Follow a customer call and identify the problem and the agreed action.',
  ),
  ListeningResource(
    ExamLevel.b1,
    'A student discussion',
    'student-discussion',
    'Follow two students comparing information about Mars and Earth.',
  ),
  ListeningResource(
    ExamLevel.b1,
    'A weather forecast',
    'weather-forecast',
    'Pick out weather details and the places and times they refer to.',
  ),
  ListeningResource(
    ExamLevel.b1,
    'An interview about listening skills',
    'interview-about-listening-skills',
    'Listen for practical advice about developing listening skills.',
  ),
  ListeningResource(
    ExamLevel.b2,
    'A business interview',
    'business-interview',
    'Follow an explanation of an app, its purpose and its future plans.',
  ),
  ListeningResource(
    ExamLevel.b2,
    'A design presentation',
    'design-presentation',
    'Identify product features, sizes and the stages of a launch.',
  ),
  ListeningResource(
    ExamLevel.b2,
    'A talk about motivation',
    'talk-about-motivation',
    'Follow the main ideas and supporting examples in a talk.',
  ),
  ListeningResource(
    ExamLevel.b2,
    'Creating a study group',
    'creating-study-group',
    'Track suggestions, decisions and who can participate in a discussion.',
  ),
  ListeningResource(
    ExamLevel.c1,
    'A project management meeting',
    'project-management-meeting',
    'Track responsibilities, objections and negotiated solutions in a meeting.',
  ),
  ListeningResource(
    ExamLevel.c1,
    'Catching up after a trip',
    'catching-after-trip',
    'Follow informal conversation, interruptions and changes of topic.',
  ),
  ListeningResource(
    ExamLevel.c1,
    'A job interview',
    'job-interview',
    'Follow detailed accounts of professional experience in an interview.',
  ),
  ListeningResource(
    ExamLevel.c1,
    'Challenges at work',
    'challenges-work',
    'Distinguish the business challenges described by different speakers.',
  ),
];
