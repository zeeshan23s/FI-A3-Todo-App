# Todo Application
## Project Overview
The Todo Application is a mobile application that allows users to manage their daily tasks and to-do lists. It incorporates Firebase for authentication (both email and Google authentication) and Firestore to store and sync task data across devices.

## Features
### User Authentication
- **Firebase Email Authentication**: Users can create an account and log in using their email and password. Firebase handles user authentication securely.
- **Google Authentication**: Users can also log in using their Google accounts, providing a convenient and seamless authentication option.

### Task Management
- **Create Tasks**: Users can create tasks by providing a title, description, and due date. These tasks are then stored in the Firebase Firestore database.
- **View Tasks**: Users can view their tasks on the main screen, organized by their due dates.
- **Update Tasks**: Users can edit task details, including the title, description, and due date.
- **Delete Tasks**: Users can remove tasks from their list when they are completed or no longer relevant.
- **Mark Tasks as Completed**: Users can mark tasks as completed, making it easier to track their progress.

### Real-time Sync
- **Real-time Data Sync**: Task data is stored in Firebase Firestore, ensuring that changes made on one device are instantly reflected on all connected devices, providing a seamless and consistent experience.

## Getting Started
### Prerequisites
Before you start, make sure you have the following installed:

- **Flutter SDK**: You can download and install Flutter from the official Flutter website.
- **Firebase Account**: You need to create a Firebase project and configure it with your Flutter app. Follow the Firebase setup instructions in the Firebase documentation.
- **Flutter IDE**: You can use Android Studio with the Flutter plugin, Visual Studio Code with the Flutter extension, or any other Flutter-compatible IDE.

### Installation
- Clone the repository to your local machine:<br>
***git clone https://github.com/your-username/todo_application.git***
- Navigate to the project directory:<br>
***cd todo_application***
- Install the project dependencies:<br>
***flutter pub get***
- Configure Firebase:
  - Follow the Firebase setup instructions to add your Firebase project configuration files to the project.
  - Make sure to enable Email/Password and Google sign-in methods in your Firebase Authentication settings.
- Run the app:<br>
***flutter run***
## Folder Structure
Here's a brief overview of the project's folder structure:
- **lib**: Contains the Dart source code for the Flutter app.
  - **screens**: Contains the app's screens (e.g., login, task list, task detail).
  - **models**: Defines the data models used in the app.
  - **services**: Contains Firebase services for authentication and Firestore data management.
  - **widgets**: Custom widgets used in the app.
- **android**: Contains the Android-specific configuration files.
- **ios**: Contains the iOS-specific configuration files.
- **test**: Contains unit and widget tests for the app.
## Contributing
Contributions to this project are welcome. If you'd like to contribute, please follow these guidelines:
- Fork the repository.
- Create a new branch for your feature or bug fix.
- Make your changes and submit a pull request.
## License
This project is open-source and available under the MIT License.
