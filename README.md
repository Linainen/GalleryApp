# Gallery App

Hey, my name is Siarhei, I'm an iOS developer and I'm glad to present you my brilliant $1 billion gallery app.
This is a basic gallery app which allows you to browse images, add the ones you like to a 'favorite' collection and even
save them locally on your device! Sounds great, doesn't it?

# Current Features:
1. Images are provided by Unsplash API.
2. You can like and unlike the photos on the main screen and on the detail screen
3. Once the image is liked, it's added to your favorites collection. If you dislake the image, it's instantly removed.
4. You can download the photo locally on your phone by tapping top-right corner button on a Detail screen.

<a href="url"><img src="https://github.com/Linainen/GalleryApp/assets/98283252/f908219b-06c4-4249-beed-1e01c65f8c77" align="center" height="540" width="750" ></a>

# Technolgies used:
* Swift - Swift is a general-purpose, multi-paradigm, compiled programming language developed by Apple Inc. for iOS, iPadOS, macOS, watchOS and more.
* MVVM architecture alongside with Delegates design pattern.
* Native CoreData is used for data persistance.
* Third party libraries such as Kingfisher, ProgressHud, SwiftLint are used for better performance and UI experience.
* All the images are cached once downloaded from the server. Thanks Kingfisher for that!

# Installation:
Clone the repository:
https://github.com/Linainen/GalleryApp.git

Install the application dependencies:
$ cd /GalleryApp /n
$ pod install

Open the file GalleryApp.xcworkspace with XCode
Click on the play button and enjoy the app!

# Future Features
* Add account management
* Add other images collections
* Add the option to search images with different keywords.
