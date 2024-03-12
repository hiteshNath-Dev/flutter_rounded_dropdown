# Flutter RoundedDropDown

[![pub package](https://img.shields.io/pub/v/flutter_zoom_drawer.svg)](https://pub.dev/packages/flutter_spin_wheel_menu) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package with custom implementation of the DrownDown with Soft corner/Rounded

## 🌟 Getting Started

To start using this package, add `flutter_rounded_dropdown` dependency to your `pubspec.yaml`

```yaml
dependencies:
  flutter_rounded_dropdown: "<latest_release>"
```

## 📌 Simple Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_rounded_dropdown/flutter_rounded_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Rounded DropDown Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> dropDownItems = ['India', 'America', 'China', 'Australia'];
  final String initialDropDownValue = 'India';
  String? selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RoundedDropDown(
                  dropDownItems: dropDownItems,
                  initialDropDownValue: initialDropDownValue,
                  onValueChanged: (String value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
              Text(
                '$selectedValue',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

## 📝 Documentation

```dart
    RoundedDropDown(
                  dropDownItems: ['India', 'America', 'China', 'Australia'],
                  initialDropDownValue: 'India',
                  onValueChanged: (String value) {
                   print('selected value is $value')
                  }),
```

## Screens

![Example app Image](https://drive.google.com/file/d/1JYM_rl9qmK_cuHMb8-ZKZy_Bm2egUjSm/view)

![Example app Demo](https://drive.google.com/file/d/1JZZJm-0KnGwxNWMdcm-gAn_irP_7piDQ/view)


## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/medyas/flutter_spin_wheel_menu/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/fussion-integrator/flutter_spin_wheel_menu/pulls).

## Credits

Credits goes to [ChidiebereEdeh](https://github.com/fussion-integrator) as most of this package comes from his implementation.
