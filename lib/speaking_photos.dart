/// Every photograph Speaking Part 2 uses, and who took each one.
///
/// They live in one place because C1 reuses B2's: its task shows three
/// pictures where B2 shows two, so each C1 set is a B2 pair plus a third on the
/// same theme. Written twice, a credit would sooner or later be corrected in
/// one copy and not the other.
///
/// None of them is Cambridge's. They are free photographs from Unsplash —
/// checked one by one to be outside Unsplash+ — and scripts/speaking_photos.tsv
/// records the address each was fetched from.
library;

import 'speaking_data.dart';

abstract final class Fotos {
  // ── B1: one photograph to describe ───────────────────────────────────────
  static const cooking = SpeakingPhoto(
    'b1-cooking',
    'Annie Spratt',
    'UyEmagArOLY',
  );
  static const football = SpeakingPhoto(
    'b1-football',
    'Simone Franchina',
    'y_sf8j3K2ZY',
  );
  static const market = SpeakingPhoto('b1-market', 'Stephan HK', 'R-xqhYU4ZKs');
  static const beach = SpeakingPhoto(
    'b1-beach',
    'Natalya Zaritskaya',
    'SIOdjcYotms',
  );
  static const station = SpeakingPhoto(
    'b1-station',
    'Dominic Kurniawan Suryaputra',
    'mTiPBTvoqVQ',
  );
  static const camping = SpeakingPhoto(
    'b1-camping',
    'Colin + Meg',
    'XDt4MuJ58LI',
  );

  // ── B2: pairs to compare ─────────────────────────────────────────────────
  static const studyLibrary = SpeakingPhoto(
    'b2-study-library',
    'Praveen Gupta',
    'YhfxJpa_Ch0',
  );
  static const studyCafe = SpeakingPhoto(
    'b2-study-cafe',
    'Ninthgrid',
    '0YBdk_6mSvY',
  );
  static const jobGarden = SpeakingPhoto(
    'b2-job-garden',
    'Jed Owen',
    '1JgUGDdcWnM',
  );
  static const jobConstruction = SpeakingPhoto(
    'b2-job-construction',
    'Valerie V',
    'PDjpA1yeonw',
  );
  static const celebrateBirthday = SpeakingPhoto(
    'b2-celebrate-birthday',
    'Vitaly Gariev',
    'E1qHLWspl-k',
  );
  static const celebrateGraduation = SpeakingPhoto(
    'b2-celebrate-graduation',
    'RUT MIIT',
    'hpRGrfOIybc',
  );
  static const commuteBike = SpeakingPhoto(
    'b2-commute-bike',
    'Vitaly Gariev',
    'wYwm3Z0HvXg',
  );
  static const commuteMetro = SpeakingPhoto(
    'b2-commute-metro',
    'Zoshua Colah',
    'X-nIOMKmGZY',
  );
  static const learnPottery = SpeakingPhoto(
    'b2-learn-pottery',
    'Maggie Markel',
    'oRbtEWw_l04',
  );
  static const learnGuitar = SpeakingPhoto(
    'b2-learn-guitar',
    'Vitaly Gariev',
    'S-vWVfbGr28',
  );
  static const mealPicnic = SpeakingPhoto(
    'b2-meal-picnic',
    'Toa Heftiba',
    'q1QDZtYP2ow',
  );
  static const mealRestaurant = SpeakingPhoto(
    'b2-meal-restaurant',
    'tommao wang',
    'MAFMkfevd7w',
  );

  // ── C1: the third picture of each set ────────────────────────────────────
  static const studyPark = SpeakingPhoto(
    'c1-study-park',
    'vos amo',
    'ClMawWBYAzU',
  );
  static const jobFishing = SpeakingPhoto(
    'c1-job-fishing',
    'Paul Einerhand',
    'JFOG2KEZSMs',
  );
  static const celebrateTrophy = SpeakingPhoto(
    'c1-celebrate-trophy',
    'Peter Zhan',
    'dyfgROHIbrY',
  );
  static const commuteCar = SpeakingPhoto(
    'c1-commute-car',
    'Art Markiv',
    'zAm1sdicGXc',
  );
  static const learnCooking = SpeakingPhoto(
    'c1-learn-cooking',
    'Trường Trung Cấp Kinh Tế Du Lịch Thành Phố Hồ Chí Minh CET',
    'GF_XTjtTSgc',
  );
  static const mealStreet = SpeakingPhoto(
    'c1-meal-street',
    'Michael Lock',
    'WrjXO5ejQ4A',
  );
}
