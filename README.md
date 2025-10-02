# Flutter-FastAPI-FoodInfoApp
An app that allows searching up a `Food` and it's information, built with Flutter and Fast API. 
_Note: this is a take home assignmentfor a technical test_

## Requirements and Progress 

| Feature | Progress |
|---|Backend|---|
| Food Search Endpoint | 100% |
| Food Details Endpoint | 0% |
| API Documentation | 0% |
|---|Backend|---|
| Search Screen | 100% |
| Key Nutrients Screen | 20% |
| Basic Navigation | 80% |

## Setup Instructions
# Prerequisites
- Flutter SDK (latest stable)
- Python 3.8+
- USDA FoodData Central API key
- Code editor (VS Code, Android Studio, etc.)

# Build & Run
Clone the repo and in `VS Code`, choose the root folder via `File > Open Folder`

**Backend**
In the `Terminal`, first `cd` to the backend folder, and run
```
pip install -r requirements.txt
copy .env.example .env
notepad .env        # USDA_API_KEY=[insert your FDC API key here]
```
to set up the test environment.

Then, run
```
uvicorn main:app --reload --port 8000
```
to host the backend on your local server.

**Frontend**
`cd` to the `frontend\flutter_application_1` folder, and run
```
fultter pub get
```
to set up the environment.

Then, in `VS Code`, got the the right bottom corner, and set the atrget platform to `Windows`.
Hit the `Run and Debug` button, or use the shorcut `Ctrl+Shift+D`.
If successful, you will see a new application popup




