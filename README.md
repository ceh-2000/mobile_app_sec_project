# Follow the Money 
## Created for Mobile App Security class (CSCI 445 @ W&M, Fall 2021)

### Application Overview
Follow the Money allows users to track their paper money. Simply make an account and you'll be able to upload and track dollar bills. Simply scan a bill and put it back into circulation. You'll be able to see other locations where that bill has also been scanned!

### How to run
1. Download Android Studio and set up an Android or iOS emulator or a real device. If using iOS, you also need XCode. 
2. Install Flutter.
3. Clone this repository.
4. Run `flutter pub get` to get the project dependencies.
5. In order to test with the map, you will need access to our Google API key or you will need to create your own and set up your own Firebase project.
6. Run `main.dart` on your emulator or real device.

### Key Features
#### Login with your email
Create an account and login with any email so the app can track for you which bills you have logged. Login information is stored and authorized with the Firestore Authentication API.

#### Photograph your bills
Simply allow the app to access the camera and you can take a picture of your bill. The picture will be sent through a Cloud API machine learning image analyzer which will read the serial number of your bill (you can also enter it manually if it is not correctly read).

#### View bill locations on a map
Once you have logged a bill, you can view any previous locations where that bill (identified by its serial number) has been logged by any user. All of the locations a bill has been logged are stored in a Firestore database. When you want to view the locations for a certain bill, these geopoints are retrieved from the database and displayed using the Google Maps API. You can choose from the list of bills that your current user has logged, which is stored locally.

### How to Use
#### Make an Account
Begin by making an account. To make an account, click "Home" then "Create new account." Enter an email and password (and confirm the password), and click submit. You must enter a valid email and a password with at least six characters.

#### Log into an Existing Account
To log into an existing account, enter the email and password you entered earlier when you created an account OR enter the following credentials:      
```Username: test@test.com```    
```Password: password```   

We have added some dummy data associated with this account to your local device on app startup, so two additional bills should be available when you filter from the map screen.

#### Add a bill
To log a new dollar bill, click the camera button in the bottom bar. Accept the permissions when prompted and take a picture of your bill. This will take you to a new screen with the bill ID extracted from your image via machine learning. If the extracted ID does not match your bill's ID, tap on the ID and edit the text. Then press the purple check mark button to upload the bill ID and your username locally and the bill ID and your location to Firebase. 

#### Filter the map
Click the map button to view the map. Press the purple home button in the bottom left corner to center the map on your current location. Accept the permissions to access your location. If you recently logged a bill, you should see a new red marker on your location. You can even "Follow the Money" by clicking all of the red markers and seeing if they were logged first, second, third, etc. Click the filter icon in the upper right corner of the "Map" screen to view a list of all bills you have ever uploaded. Select a different bill and tap the purple "Update Map" button to view the map for that bill. You can change what bill you want to filter on as many times as you want.

#### Log out
To log out, click the camera button again from the bottom bar. Click the logout icon in the upper right corner. You will be taken back to the login screen.

### Notes
- If you don't move from when you last logged a bill with a specific ID, you will not be able to log that bill ID again until you move.
- You may have to take a picture of just the serial number and not the entire bill so that the serial number can be read accurately. Remember, if you continue to have problems producing the bill ID, you can always enter it manually. 
