# Instagram Clone Project

## Overview

This project is an Instagram clone with a Flutter frontend and a Django backend. The backend provides RESTful endpoints for managing posts, reels, user profiles, messages, and more. The frontend interacts with these endpoints to create a seamless user experience similar to Instagram. The mobile code is written in a way that allows for easy integration, following Reso Coder's clean architecture strategy, which is based on principles by Robert C. Martin (Uncle Bob).

## Table of Contents

- [Project Structure](#project-structure)
- [Backend Endpoints](#backend-endpoints)
  - [Posts](#posts)
  - [Reels](#reels)
  - [Users](#users)
  - [Messages](#messages)
  - [Authentication and Validation](#authentication-and-validation)
- [Frontend Setup](#frontend-setup)
- [Backend Setup](#backend-setup)
- [Running the Application](#running-the-application)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

```
instagram_clone/
├── frontend/
│   └── 
├── backend/
│   └── 
└── README.md
```

## Backend Endpoints

The backend provides several RESTful endpoints to manage the various functionalities of the Instagram clone.

### Posts

- `GET /posts/` - List all posts
- `POST /posts/` - Create a new post
- `GET /posts/{post_id}/` - Retrieve a specific post
- `PUT /posts/{post_id}/` - Update a specific post
- `DELETE /posts/{post_id}/` - Delete a specific post

#### Nested Endpoints

- `GET /posts/{post_id}/comments/` - List all comments on a post
- `POST /posts/{post_id}/comments/` - Add a comment to a post
- `GET /posts/{post_id}/likes/` - List all likes on a post
- `POST /posts/{post_id}/likes/` - Like a post

### Reels

- `GET /reels/` - List all reels
- `POST /reels/` - Create a new reel
- `GET /reels/{reel_id}/` - Retrieve a specific reel
- `PUT /reels/{reel_id}/` - Update a specific reel
- `DELETE /reels/{reel_id}/` - Delete a specific reel

#### Nested Endpoints

- `GET /reels/{reel_id}/comments/` - List all comments on a reel
- `POST /reels/{reel_id}/comments/` - Add a comment to a reel
- `GET /reels/{reel_id}/likes/` - List all likes on a reel
- `POST /reels/{reel_id}/likes/` - Like a reel

### Users

- `GET /users/` - List all users
- `POST /users/` - Create a new user
- `GET /users/{user_id}/` - Retrieve a specific user profile
- `PUT /users/{user_id}/` - Update a specific user profile
- `DELETE /users/{user_id}/` - Delete a specific user profile

### Messages

- `GET /messages/` - List all messages
- `POST /messages/` - Send a new message
- `GET /messages/{message_id}/` - Retrieve a specific message
- `DELETE /messages/{message_id}/` - Delete a specific message

### Authentication and Validation

- `POST /checkEmail/` - Check if an email is already registered
- `POST /checkCode/` - Verify confirmation code
- `POST /checkUsername/` - Check if a username is available

## Frontend Setup

To set up the frontend:

1. Ensure you have Flutter installed. For installation instructions, visit [Flutter's official site](https://flutter.dev/docs/get-started/install).
2. Navigate to the frontend directory:
   ```bash
   cd frontend/instagram_clone_flutter
   ```
3. Install the required dependencies:
   ```bash
   flutter pub get
   ```
4. Run the Flutter application:
   ```bash
   flutter run
   ```

## Backend Setup

To set up the backend:

1. Ensure you have Python and Django installed. For installation instructions, visit [Django's official site](https://www.djangoproject.com/start/).
2. Navigate to the backend directory:
   ```bash
   cd backend/instagram_clone_django
   ```
3. Create a virtual environment and activate it:
   ```bash
   pip install pipenv
   pipenv install
   pipenv shell
   ```
4. Run the Django development server:
   ```bash
   python manage.py runserver
   ```

## Running the Application

1. Start the backend server by following the steps in the Backend Setup section.
2. Run the frontend application by following the steps in the Frontend Setup section.
3. Open the Flutter app on your emulator or device. The app will connect to the backend server to fetch and display data.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes. Ensure your code follows the project's coding standards and includes appropriate tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
