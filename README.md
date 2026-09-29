# Cíl

*Cíl* is Czech for **goal, target, the thing you are aiming at**. It is the
sibling of **Píle** — *diligence* — the app it was pulled out of: diligence
gets you to the goal.

Practice for **B2 First** and **C1 Advanced**, with nothing personal attached.

It is deliberately **not** called anything with *Cambridge* in the name. This
is an unofficial study aid; Cambridge Assessment English has nothing to do with
it, and the name should not suggest otherwise.

## What it has

- **Practice** — 30 exercises that explain *why* the answer is the answer,
  grouped by topic, plus a glossary of every exam task type with a worked
  example of each. What a *cloze* is, what a *gapped text* is, what
  *multiple matching* means.
- **Mock test** — sit the paper on paper, type your answers in, and it marks
  them part by part. B1 Preliminary, B2 First sample paper 2 and the C1
  Advanced sample paper from the official handbook. The Listening audio is
  Cambridge's, so the app points at where to download it rather than shipping
  a copy.
- **Writing** — a paper-white editor with a live word count and a clock. The
  count is the point: 140–190 words at B2, 220–260 at C1, and almost nobody
  judges that by eye. The draft saves as you type.
- **Speaking** — a timer per part, a prompt that shuffles, and the phrases
  examiners are listening for, including ways to open an answer.
- **The exam** — how each paper works, what it weighs, how it is scored, and
  what changes between B2 and C1.

## What it deliberately does not have

- **Anything personal.** No schedule, no to-do list, no contacts, no payments.
- **No accounts, no servers.** What you practise is stored on your phone and
  never leaves it. Works offline.
- **Not Cambridge's booklets.** The app holds the exam structure and the answer
  keys so it can mark you, not the texts of the papers. The sample papers are
  free to download from Cambridge, and real practice happens on paper anyway.

## Building it

```bash
flutter build apk --release
```

The APK lands in `build/app/outputs/flutter-apk/app-release.apk`. Install with
`adb install -r`, or send the file to someone and let them open it with
installation from unknown sources enabled.

## Pick your goal

The two chips at the top — **FCE** and **CAE** — set what you are working
towards, and the choice sticks. It is not decorative: aiming at B2 hides the C1
material, which would only be a distraction until you get there. Aiming at C1
adds topics like inversion and hedging on top of everything B2 already has.

## Where it came from

This is the *English* section of Píle, an app built during a term at Cumorah
Academy in Prague. The module was written in isolation from the start, so
splitting it out meant copying nine files and writing a smaller state class:
here, only practice scores, mock attempts and Writing drafts are stored.
