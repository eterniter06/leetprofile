# Contributing
No specific requirements for contributing.

# Project File Structure
The project files are organized based on screens.
Each screen comprises a folder containing a dart file and optionally a components subfolder. The folder and the dart file are both named after the name of the screen itself.

Widgets restricted to a particular screen can be found under the screen's "components" folder (if the screen has numerous widgets) and widgets that are used across multiple screens will be under "lib/common_components/widgets".

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