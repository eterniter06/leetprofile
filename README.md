# LeetProfile

<p align="center">
    <img src="assets/ic_launcher-playstore.png" height="100px"/>
    <h1 align="center">LeetProfile</h1>
    <h4 align="center">
      An android app that offers an organized way to look at multiple Leetcode profiles
    </h4>
  <br>
</p>

[Insert some pics] 

# Permissions
- Network access
- Storage

# Getting started
## Getting the apk
This app is not available on the play store and it may remain that way. There are currently two ways to get the apk:
- Install the apk from the releases page.
- Build the apk yourself.
## Building the apk
Skip this section if you have already installed the apk from the releases page.
1. Clone this repository to your desktop.
2. Run `flutter pub get` to fetch the required dependencies.
3. Run `flutter build apk` to build the app.
4. Send the apk to your phone and install manually or connect your android device to your computer and run `flutter install`.

## Using the app
### Deleting profiles
### Opening leetcode links in the app

# Todos
[] Fuzzy search on existing profiles 
[] App localization
[] Option to disable UserView listings (Skills/Language/...)

# Project File Structure
The project files are organized based on screens.

## Screens
Each screen comprises a folder containing a dart file and optionally a components subfolder. The folder and the dart file are both named after the name of the screen itself.

## Widgets
Widgets restricted to a particular screen can be found under the screen's "components" folder (if the screen has numerous widgets) and widgets that are used across multiple screens will be under "lib/common_components/widgets".

## ChangeNotifiers
All ChangeNotifiers classes (user classes implementing ChangeNotifiers) are under "lib/providers"

## Sample file structure
```
lib
├── common_components
│   ├── interfaces.dart
│   ├── lib
│   │   └── ...
│   ├── ui_vars.dart
│   └── widgets
│       └── ...
├── database
│   ├── settings_database.dart
│   └── user_database.dart
├── dataclass
│   ├── http_wrapper
│   │   └── ...
│   ├── query_class
│   │   └── ...
│   └── user_class
│       └── ...
├── image
│   └── squircle_network.dart
├── main.dart
├── pages
│   ├── about
│   │   └── about.dart
│   ├── home
│   │   ├── components
│   │   │   └── ...
│   │   └── home.dart
│   ├── profile
│   │   ├── components
│   │   │   └── ...
│   │   └── user_view.dart
│   └── settings
│       ├── components
│       │   └── ...
│       └── settings.dart
└── providers
    └── ...

```

# References
- List of languages usable on Leetcode: https://support.leetcode.com/hc/en-us/articles/360011833974-What-are-the-environments-for-the-programming-languages-

# Sources
- Language icons: https://devicon.dev/
    - Racket: https://www.logo.wine/logo/Racket_%28programming_language%29
- Fonts: https://fonts.google.com/specimen/Overpass/about
- Illustrations: https://undraw.co
