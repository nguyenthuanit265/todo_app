# Flutter TODO List App

A feature-rich TODO list application built with Flutter that helps users manage their tasks efficiently with time-based
reminders and different viewing categories.

## Features

- ✅ Create TODOs with customizable time settings
- 🗂️ View TODOs by categories (All/Today/Upcoming)
- 🔍 Search functionality to find specific TODOs
- 🔔 Notification alerts 10 minutes before TODO due time
- ✓ Mark TODOs as completed
- 📱 Cross-platform support (iOS and Android)

## Screenshots

[Place your app screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK (version 3.x or higher)
- Dart SDK (version 3.x or higher)
- Android Studio / Xcode for mobile development
- A physical device or emulator for testing

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/todo_list_app.git
```

2. Navigate to the project directory:

```bash
cd todo_list_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

### Dependencies

The app uses the following packages:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_local_notifications: ^16.3.0
  timezone: ^0.9.2
  # Add other dependencies your project uses
```

## Project Structure

```
lib/
  ├── main.dart
  ├── models/
  │   └── todo.dart
  ├── screens/
  │   └── home_screen.dart
  ├── services/
  │   └── notification_service.dart
  └── widgets/
      └── [widget files]
```

## Features in Detail

### 1. TODO Creation

- Users can create new TODOs with titles
- DateTime picker for selecting due date and time
- Automatic notification scheduling

### 2. Category Views

- All: Shows all uncompleted TODOs
- Today: Shows TODOs due today
- Upcoming: Shows future TODOs

### 3. Search Functionality

- Real-time search through TODO titles
- Case-insensitive search
- Instant results as you type

### 4. Notifications

- Local notifications using flutter_local_notifications
- 10-minute advance reminders
- Support for both Android and iOS

### 5. TODO Management

- Mark TODOs as complete
- Remove completed TODOs from the list
- View TODO details

## Platform-Specific Setup

### Android

Add the following permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml

<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
```

### iOS

Add the following to your `ios/Runner/Info.plist`:

```xml

<key>UIBackgroundModes</key>
<array>
<string>fetch</string>
<string>remote-notification</string>
</array>
<key>NSCalendarsUsageDescription</key>
<string>This app needs calendar access for task scheduling</string>
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Known Issues

- [List any known issues or limitations]
- [Include workarounds if available]

## Future Enhancements

- [ ] Add task categories/tags
- [ ] Implement data persistence
- [ ] Add recurring tasks
- [ ] Include task priority levels
- [ ] Add dark mode support
- [ ] Implement task sharing

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

- Flutter team for the amazing framework
- Contributors and package maintainers
- [Add any other acknowledgments]