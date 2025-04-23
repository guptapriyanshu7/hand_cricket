# Hand Cricket

Hand Cricket is a simple and fun game where you play against a bot. You choose a number between 1 and 6, and so does the bot. If the numbers match, you're out! Otherwise, your number is added to your score. The goal is to score more runs than the bot.

## Features

- Interactive and user-friendly interface.
- Simple and engaging gameplay.
- Score tracking and game state management.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension for development.

### Installation

1.  Clone the repository:

    ```sh
    git clone https://github.com/guptapriyanshu7/hand_cricket.git
    ```

2.  Navigate to the project directory:

    ```sh
    cd hand_cricket
    ```

3.  Install dependencies:

    ```sh
    flutter pub get
    ```

### Running the App

1.  Connect a physical device or start an emulator.
2.  Run the app:

    ```sh
    flutter run
    ```

## Project Structure

```
hand_cricket/
├── android/           # Android specific files
├── ios/               # iOS specific files
├── lib/               # Dart source code
│   ├── core/         # Core functionalities and utilities
│   ├── data/         # Data sources and repositories
│   ├── domain/       # Domain entities and use cases
│   ├── presentation/ # UI/Screens and related logic
│   ├── main.dart     # Entry point of the application
├── pubspec.yaml       # Project dependencies and configurations
└── README.md          # Project documentation
```

## Contributing

Contributions are welcome! Feel free to open issues and submit pull requests.

## License

[MIT](LICENSE)
