****************WAYMAP README****************

Contributors:
Carlos Arellano
Jean Jeon

**********Features**********

WayMap is an app that uses GPS features to track a user’s most frequented areas, such as their route home to and from work. Using this data, WayMap will provide the user with suggestions of things to do, such as nearby events to attend, things to see, or places to go. The user will also be able to specify their interests so that WayMap will be able to provide them with further customized suggestions. Ultimately, WayMap’s goal is to help everyone explore a little more every day.

- Tracks User Location
- Shows Places nearby User based on User-selected radius
- Allows Users to add their own locations
- Allows Users to Favorite, Check In and Rate (Rating only available for User Added Locations).

**********************Installation**********************

1. Before running, ensure to install pod file using command line in the relevant podfile folder:
    $ pod install
    
    (If you do not have Cocoapods install, please visit https://cocoapods.org/ for instructions on how to install the application).
    
2.  App requires registration, so ensure that you register your app with an email and password.

3. If running on Simulator, ensure that Debug>Location>None is changed to a valid location (e.g. Apple).
    **Camera feature will *not* work on Simulator.**

****WAYMAP Sources****

Google Places API - Uses Google's API to retrieve places nearby. Because we use the likelihood list, the location list given is limited. To gain more locations nearby, we would have to alter the use of API to retrieve more locations.

MapBox Framework - Includes the Map and all relevant annotations on the map.

Firebase - Stores User data, including favorited, checked in place and user added locations, onto firebase and loads data when user signs in.

******Main View Controllers******

Login  &Register View Controllers - Logins or registers users using Firebase data.

MapView Controller - Updates location every 2 seconds, passing data into a local array which is sent to the App Delegate Controller for use by other View Controllers. Additionally, loads data from Firebase and places it in relevant parts of the app (updates all favorited, checked in, User Added Locations).

TipsFirstTableViewController - Retrieves array of categories from the Map View Controller and sorts out data into categories. Segues into another view controller which shows relevant information, and shows the Place in the Places Info View Controller. Also contains Surprise Me feature which randomly chooses data.

User Info - Retrieves Favorited and User Added Places locations from Firebase and adds data to a table view controller for the User to see.

Add New Place View Controller - Allows user to add a new place, and stores data in Firebase.

GooglePlace View Object - Custom object that takes Google Places API locations and stores them as local objects to pass around in the app.

********Source Code********
https://github.com/WayMappers/WayMap

