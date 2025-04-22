[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

# Nutri+

<br />
<p align='center'>
  <a>
    <img src=NutriPlus/Supporting/Assets.xcassets/applogo.imageset/180.png alt="logo" width="80" heightt="80">
  </a>

  <p align="center">
    Tracking meals, getting insights and living a healthier life never been much easier with AI-powered Nutri+.
    
  </p>

</p>

## Screenshots and Demos

#### Authenticate with Firebase and fill up your personal assessment data to experience Nutri+ properly.
<p align="row">
<img src= /repo-assets/login+assessments.gif width="200">
<img src= /repo-assets/home-module.gif width="200">
</p>

#### Easily track your meals — add them manually or scan their images using Gemini AI.
<p align="row">
<img src= /repo-assets/scan-meals-with-ai.gif width="200">
<img src= /repo-assets/add-meals-manually.gif width="200">
</p>

## Meta
Ertan Yağmur – [Medium](https://ertanyagmur.medium.com) - [LinkedIn](https://www.linkedin.com/in/ertanyagmur) – ertanyagmur@outlook.com

## Platform & Requirements

Nutri+ is a native iOS application built with Swift and UIKit, designed to offer seamless meal tracking and nutritional insights.

- iOS 15.2+
- Xcode 14.0+

## Third-Party Libraries

Nutri+ utilizes several third-party libraries for enhanced functionality. Below is a list of the libraries used:

- ![Firebase](https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black)  

- ![Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)

- Lottie
  
## Architecture

Nutri+ follows **MVVM** architecture to ensure separation of concerns and better maintainability. The app utilizes **Dependency Injection (DI)** for modularity and scalability. By adopting **Protocol-Oriented Programming**, the project ensures flexibility and ease of testing.

**Combine** is used to bind the **UI** with the **ViewModel**, providing a reactive and efficient approach for handling updates and changes in the user interface.

## AI Integration with Gemini

Nutri+ leverages **Gemini AI** for food recognition and nutritional insights. Users can capture photos of their meals, which are sent to Gemini along with a specific instruction. Gemini processes the image and returns a structured **JSON** response containing the meal’s name, calories, and nutritional information.

In addition to meal recognition, Nutri+ integrates a **chat** feature with Gemini, allowing users to receive personalized health and diet advice, much like consulting a nutritionist.

## Data Storage and Authentication

Nutri+ uses **Firebase Firestore** for data storage, ensuring real-time updates and seamless synchronization across devices. All meal data, including user-specific nutrition information, is securely stored in the cloud.

**Firebase Authentication** is implemented to manage user sign-in and sign-up, providing a secure and simple way for users to access their personalized meal tracking data.

## Firebase and Gemini AI Setup

### Firebase Configuration

To enable Firebase functionality in Nutri+, you need to add your **GoogleService-Info.plist** file to the project:

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or select an existing project.
3. Add an **iOS application** to your Firebase project.
4. Download the **GoogleService-Info.plist** file and place it in the **Supporting** directory of the project.

### Gemini AI API Key Configuration

To use Gemini AI for food recognition and nutritional insights, you must configure your **API key**:

1. Create a **secrets.json** file with your Gemini AI API key:

```
  "GEMINI_API_KEY": "YOUR_API_KEY"
```
2. Set this file as configuration for both debug and release in the project settings.

## Testing

Currently, **unit tests** have not been implemented for this project. Although the app follows best practices in terms of architecture and modularity, automated tests are yet to be added.

## Contribute
I would love you for the contribution to the project, check the ``LICENSE`` file for more info.

[app-logo]: NutriPlus/Supporting/Assets.xcassets/applogo.imageset/180.png
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-url]: LICENSE
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
