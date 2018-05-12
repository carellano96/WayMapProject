****************WAYMAP README****************

Contributors:
Carlos Arellano
Jean Jeon

**********Summary**********

WayMap is an app that uses GPS features to track a user’s most current area, and provide the user with highly localized suggestions of things to do based on this data. This includes nearby events to attend, landmarks to see, or places to go. The user will also be able to specify their interests so that WayMap will be able to provide them with further customized suggestions. Further, WayMap allows users to upload their own events and places to the app, facilitating the process of publicizing non-permanent events and establishments. This feature undergoes layers of vetting in order to ensure that whatever is displayed by WayMap is as quality as possible. Ultimately, WayMap’s goal is to help everyone explore a little more every day.

**********Features**********

- Tracks User Location
- Shows Places nearby User based on User-selected radius
- Allows Users to add their own locations
- Allows Users to Favorite, Check In and Rate (Rating only available for User Added Locations).

**********************Installation**********************

1. Before running, ensure to install pod file using command line in the relevant podfile folder:
    $ pod install
    
    (If you do not have Cocoapods install, please visit https://cocoapods.org/ for instructions on how to install the application).
    
    **Ensure that the file being opened is WayMap.xcworkspace**
    
2.  App requires registration, so ensure that you register your app with an email and password.

3. If running on Simulator, ensure that Debug>Location>None is changed to a valid location (e.g. Apple).
    **Camera feature will *not* work on Simulator.**

****WAYMAP Sources****

Google Places API - Uses Google's API to retrieve places nearby. Because we use the likelihood list, the location list given is limited. To gain more locations nearby, we would have to alter the use of API to retrieve more locations.

MapBox Framework - Includes the Map and all relevant annotations on the map.

Firebase - Stores User data, including favorited, checked in place and user added locations, onto firebase and loads data when user signs in.

******Obstacles******

- Learning Firebase, Google Places API and Mapbox in a short period of time was challenging.
- Collaberating over Github with XCode took trial and error, as there were issues with DS.Store and merge conflicts.
- Juggling between tab view controllers and passing data efficiently between them was very tricky!

******Main View Controllers******

Login  & Register View Controllers - Logins or registers users by checking against user data stored in Firebase. Checks for errors thrown, such as the password not being long enough in case of registration, and password or email being incorrect in case of logging in.

MapView Controller - Updates location every 2 seconds, passing data into a local array which is sent to the App Delegate Controller for use by other View Controllers. Additionally, loads data from Firebase and places it in relevant parts of the app (updates all favorited, checked in, User Added Locations). Note that user-added places show up as blue diamonds, whereas permanent establishments show up as pink dots.

TipsFirstTableViewController - Retrieves array of categories from the Map View Controller and sorts out data into categories. Segues into another view controller which shows relevant information, and shows the Place in the Places Info View Controller. Also contains Surprise Me feature which randomly chooses data.

PlacesInformationViewController - Displays the name and address of a given place, as well as how far away the user is from the location. Upon pressing on the place's address, the user is taken to Apple Maps, where they are given directions to the address. If the place being displayed is a user-added places, then the current user has the option to rate the user-added place based on their experience. The user also has the option to check into the place or favorite it. All data is retrieved from Firebase, and the rating data is pushed to Firebase.

User Info - Retrieves Favorited and User Added Places locations from Firebase and adds data to a table view controller for the User to see. Also has an option for user to update their "profile" photo, in which case they can select an existing photo from their camera roll, or take one by using their phone's camera.

Add New Place View Controller - Allows user to add a new place, and stores data in Firebase.

GooglePlace View Object - Custom object that takes Google Places API locations and stores them as local objects to pass around in the app.

********Source Code********
https://github.com/WayMappers/WayMap

