# Bearer

The Bearer app is a delivery service designed for day-to-day packages such as envelopes, shopping lists, and more.

It is developed for iOS using the SwiftUI framework and follows the MVVM design pattern. The app leverages the Google Maps API to accurately pinpoint the origin and destination of packages, ensuring the safety and security of the delivery process.
 

## Files and folders Structures

The files and folders in this app are structured using vertical grouping rather than horizontal grouping, which means that related files are grouped together in the same directory instead of being separated into different folders based on file type.

Horizontal Grouping
![Horizontal Grouping](https://i.imgur.com/zwYdy7o.png)

Vertical Grouping
![Vertical Grouping](https://i.imgur.com/2yKU9NE.png)

The overall structure of app looks like this 
![Vertical Grouping](https://i.imgur.com/p55Hi6i.png)

The `Core` folder includes all files that are shared between views. Each `View` folder inside the `Views` folder contains everything necessary for the view to populate itself, and every top-level folder includes shared functionality.

## Workflow and Functionality

- `BearerApp` is the application's entry point where the initialization of Firebase and Google Maps takes place. It also contains two `@State` variables that are used as `@EnvirementObjects` throughout the app's life cycle.

`StateManager` tracks the state of pins on the map and changes the app's state accordingly for the views to be presented correctly.

`FirebaseImageCacher` is responsible for retrieving images from `FirebaseStorage` and caching them in memory. This ensures that image views do not update every time the view's state changes, improving performance.


## Views

### HomeView

HomeView serves as the primary View component in the app architecture. Its responsible for aggregating and presenting other View components to the user. It utilizes a StateManager to manage the application's state and respond to user interactions.


### MapView

MapView is a `UIViewRepresentable` derivative that integrates Google Maps into a SwiftUI application. Due to SwiftUI's limited support for maps, MapView handles the mapping experience within the view. It provides a `MapViewCoordinator` that acts as a delegate for the `MapView` and provides methods to help update, add, remove, and draw paths to the selected points.


### ParcelView

ParcelView is the popup view that appears from the bottom of the map view when the user successfully selects an origin and destination location. It requests an API call to retrieve available parcel options in the selected area at that moment.
 
### PricingView

After the user selects a parcel and taps on 'Next', the `ParcelView` is removed from the bottom of the screen, and the `PricingView` appears. The `PricingView` retrieves available carrier options through an API call to the server.

> **Note** that all the views have associated models and helper views within their directories, which are grouped together.

### Modifiers ans CommonViews

The `Views` folder contains two additional directories named 'CommonViews' and 'Modifiers'. These directories contain representations that are shared within one or more views and can be used without any coupling problems.


### Models 

Each model directory contains a data model file that is used to populate and interact with the view. 

Additionally, there is a 'Constants' object inside the top-level 'models' directory that is used as a source of truth for passing text and images to prevent typos. This also makes it easy to replace text and images in the future, should the app require localization support for multiple languages.


## Core

### Managers

The Managers directory consists of three objects, two of which have been explained above.

The third object is the `LocationManager`, which serves as the entry point for the app to use Apple's location APIs. It creates a `CLLocationManager` instance that requests user consent for using the device's location.

### Extensions

The directory contains two files:

- `Extension+View`: extends the view modifiers of the View to accept a condition when they are presented. Documentation and usage instructions for this file are provided within the file itself.

- `Extension+GMSMapView`: extends the `GMSMapView` with three different methods: `drawArcPolyline`, `zoomOutToFitMarkers`, and `addPin`. These methods are useful in handling map behavior and changing its state. Documentation for these methods can be found within the file itself. To use them, simply call `'Any subView of GMSMapView'.addPin`.


# Development

- Clone repository
- Install CocoaPods: If you don't already have CocoaPods installed on your system, you can install it by running the following command in the terminal:

```
sudo gem install cocoapods
```

For more information, checkout official documentation of CocoaPods (https://guides.cocoapods.org/using/getting-started.html)

- Install dependencies: Run the following command in the terminal to install the dependencies specified in the Podfile:

`pod install`

- Open the `.xcworkspace` file.

- Log in to the Firebase console at (https://console.firebase.google.com/). If you don't have an app registered, register one.

- From Firebase console download the `GoogleService-Info.plist`. In Xcode, drag and drop the `GoogleService-Info.plist` file into your project. Make sure to select the option to copy the file to your project if it's not already in your project directory.

Unlike Google Maps, which is integrated using CocoaPods, Firebase is integrated using Swift Package Manager. To install Firebase with Swift Package Manager in Xcode 12 and above, navigate to File > Swift Packages > Add Package Dependency and in the prompt that appears, select the Firebase GitHub repository. Make sure to select the following packages:

- FirebaseFirestore
- FirebaseFunctions
- FirebaseFirestoreSwift
- FirebaseStorage

Once the packages have been selected, Xcode will handle the installation process. It may take some time to install, depending on the size of the packages and the speed of your internet connection.

To install AlertToast using Swift Package Manager, follow the same process as installing Firebase. First, navigate to File > Swift Packages > Add Package Dependency. Then, enter the AlertToast GitHub repository URL: https://github.com/elai950/AlertToast.git.

That's it! You're ready to build and run the app.


# Dependencies

- GoogleMap
- Firebase
  - FirebaseFirestore
  - FirebaseFunctions
  - FirebaseFirestoreSwift
  - FirebaseStorage
- Alert Toast SwiftUI
  - Repository: `https://github.com/elai950/AlertToast.git`

