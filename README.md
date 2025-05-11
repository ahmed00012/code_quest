# code_quest

A new Flutter project.


 Features



User Authentication
•	Sign Up: Create a new account to access the app.
•	Login: Securely log in using your credentials.
•	Logout: Easily log out to protect your account.


Specialist Directory
•	Specialists List: Browse a list of specialists, each with their own name, image, and specialization.
•	Detailed View: Tap on any specialist to view more details in a bottom sheet, including their name, image, specialization, description, and available time slots.
•	Make Appointment: Choose a day and time from the specialist's timetable and confirm your reservation.



Appointments Management
•	View Appointments: Access a list of all your booked appointments with detailed information.
•	Edit or Cancel: Modify or cancel your appointments directly from the app.


Technologies Used
•	Flutter for cross-platform mobile development
•	Bloc for state management
•	GetIt for dependency injection
•	Clean Architecture for organized, maintainable code
•	Firebase for database structure
•	LocalStorage: Storing user session data.



Getting Started
To get started with the Reservation App, follow these steps:
Prerequisites
•	Flutter SDK (latest version recommended)
•	Dart (latest version)
Installation
1.	Clone the repository:
https://github.com/ahmed00012/code_quest.git
2.	Navigate to the project directory:
cd reservation-app
3.	Install dependencies:
flutter pub get
4.	Run the app:
flutter run



Project Structure
The app is structured according to the Clean Architecture approach:
•	lib/
o	data/ - Data sources, models
o	domain/  repositories 
o	presentation/ - UI, widgets, and state management
o	core/ - Shared components and utilities




