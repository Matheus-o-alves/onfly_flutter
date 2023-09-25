# onfly_flutter
#Project Description:
An application for managing travel expenses, allowing users to add new expenses, edit them, delete them, and send them to the API.

Installation/Setup and Running the Application:
To set up and run the application, follow these steps:

Make sure you have Flutter installed. If not, you can download it from here.

Clone this repository to your local machine using the following command:

bash
Copy code
git clone https://github.com/your-username/travel-expense-manager.git
Navigate to the project directory:

bash
Copy code
cd travel-expense-manager
Install dependencies using Flutter's package manager:


Copy code
flutter pub get
flutter pub run build_runner build
Create a .env file in the project root directory and add your API key or other configuration values if required.

Run the application using Flutter:

##Copy code
flutter run
The app should now be running on your emulator or physical device.

Summary of Approaches, Technologies, and Packages Used:
http: Used for making API requests.
get: A state management library for Flutter.
path_provider: Provides access to the device's file system.
flutter_dotenv: Used for managing environment variables.
hive: A lightweight and fast NoSQL database for Flutter.
hive_flutter: Hive's Flutter-specific implementation.
get_it: A simple service locator for Dart and Flutter.
build_runner: Used for code generation.
hive_generator: Code generation for Hive.
shared_preferences: Used for storing small amounts of data locally.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
