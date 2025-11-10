# Fitness Countdown

A lightweight Flutter app to run simple workout countdowns with configurable set duration, number of sets, and rest time. It includes audible cues, a clean circular progress indicator, and light/dark theme support.

![Splash](assets/images/timer.gif)

## Features

- Configurable session: set duration, number of sets, rest between sets
- Big circular progress button with smooth animation
- Audible cues (3–2–1, start/pause, and finish)
- Light/Dark theme toggle
- Minimal splash screen and focused UI
- Runs on Android, iOS, Web, macOS, Windows, and Linux (Flutter support required)

## Getting Started

Prerequisites:

- Flutter SDK installed (3.4.0 or newer recommended)
- A device or emulator/simulator

Install dependencies:

```bash
flutter pub get
```

Run on a connected device or simulator:

```bash
flutter run
```

## Usage

1. Tap the settings (floating action button) to configure:
   - Set Duration (seconds)
   - Number of Sets
   - Pause Duration (seconds)
2. Press the large circular button to start the session.
3. Watch the countdown; 3–2–1 voice cues play near transitions.
4. Between sets, a pause countdown runs, then the next set starts automatically.
5. Use the Restart Session button anytime to reset progress.
6. Toggle light/dark theme from the AppBar button.

## Build

Common build targets:

- Android APK:
  ```bash
  flutter build apk --release
  ```
- iOS (from macOS):
  ```bash
  flutter build ios --release
  ```
- Web:
  ```bash
  flutter build web --release
  ```

Refer to Flutter’s platform docs for signing and distribution specifics.

## Project Structure

- `lib/`
  - `main.dart`: App entry, theme wiring, splash
  - `pages/`
    - `splashpage.dart`: Simple splash with logo
    - `homepage.dart`: Settings + countdown layout
  - `widgets/`
    - `countdown.dart`: Timer logic, circular indicator, audio cues
    - `settings_popup.dart`: Bottom sheet to edit session settings
    - `theme_toggler.dart`: Light/Dark switch
  - `theme/theme.dart`: Light/Dark color schemes
- `assets/images/`: Splash GIF
- `assets/sounds/`: Audio prompts (1, 2, 3, start, pause, congrats)
- `pubspec.yaml`: Dependencies and assets

## Dependencies

- `percent_indicator` – circular progress indicator
- `audioplayers` – simple cross‑platform audio playback

## Notes

- Ensure device volume is up to hear audio cues.
- On iOS/macOS, first run may prompt for media permissions depending on device settings.

## Contributing

Issues and pull requests are welcome. For larger changes, please open an issue first to discuss scope and approach.

## License

This project is licensed under the MIT License. See `LICENSE` for details.
