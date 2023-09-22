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

## Screenshots
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/c5e2df6c-71af-4e08-9dee-3d16c5d0d3fb" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/f692954c-1c5e-480b-9317-26bdd6aaaaa3" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/71c15167-640d-4383-b6e7-1fc2fe6d5c49" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/37604e68-cdfd-4bf7-a3cc-d659393b0f34" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/61f94186-b066-40ff-b28c-a416d3f28080" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/ec40538f-dc82-4945-a592-fdfe69b32571" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/c48d6cca-f863-4665-90f7-bede15ecf880" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/3a59ecf4-f982-48a3-9dd4-f7a6974ae924" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/37db0e19-352d-41b2-bc82-30df2c7ff1ee" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/1fd85d32-ec23-4b1d-8354-4ba495c795a1" width="200" height="400" /> <nbsp>
<img src="https://github.com/zeeshan564/FI-A3-Todo-App/assets/97142240/d6294322-bbdd-4d7b-80b6-85d70e18d999" width="200" height="400" />

## Getting Started
### Prerequisites
Before you start, make sure you have the following installed:

- **Flutter SDK**: You can download and install Flutter from the official Flutter website.
- **Firebase Account**: You need to create a Firebase project and configure it with your Flutter app. Follow the Firebase setup instructions in the Firebase documentation.
- **Flutter IDE**: You can use Android Studio with the Flutter plugin, Visual Studio Code with the Flutter extension, or any other Flutter-compatible IDE.

### Installation
- Clone the repository to your local machine:<br>
***git clone https://github.com/zeeshan564/FI-A3-Todo-App.git***
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
