import 'package:flutter/material.dart';
import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/infrastructure/theme/theme_extensions.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';
import 'package:provider/provider.dart';

class UiScreen extends StatefulWidget {
  static const _routeName = '/ui-screen';

  static PageRoute<UiScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const UiScreen();
      },
    );
  }

  const UiScreen({Key? key}) : super(key: key);

  @override
  State<UiScreen> createState() => _UiScreen();
}

class _UiScreen extends State<UiScreen> {
  late var dropdownValue = context.localizations!.one;
  bool isChecked = false;
  bool isSwitched = false;
  double _currentSliderValue = 20;
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.flutterTheme),
        actions: [
          PopupMenuButton<ThemeMode>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text(context.localizations!.lightMode),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text(context.localizations!.darkMode),
              ),
            ],
            onSelected: (themeMode) {
              context.read<MyAppState>().setThemeMode(themeMode);
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: DividerTheme(
          data: context.theme.dividerTheme.copyWith(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._textStyle(),
              const Divider(),
              ..._buttonStyle(),
              const Divider(),
              ..._switchesStyle(),
              const Divider(),
              _userNameField(),
              const Divider(),
              _passwordField(),
              const Divider(),
              _errorField(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _textStyle() {
    final textTheme = context.theme.textTheme;

    return [
      Text('headline1', style: textTheme.headline1!),
      Text('headline2', style: textTheme.headline2!),
      Text('headline3', style: textTheme.headline3!),
      Text('headline4', style: textTheme.headline4!),
      Text('headline5', style: textTheme.headline5!),
      Text('headline6', style: textTheme.headline6!),
      Text('subtitle1', style: textTheme.subtitle1!),
      Text('subtitle2', style: textTheme.subtitle2!),
      Text('bodyText1', style: textTheme.bodyText1!),
      Text('bodyText2', style: textTheme.bodyText2!),
      Text('button', style: textTheme.button!),
      Text('caption', style: textTheme.caption!),
      Text('overline', style: textTheme.overline!),
    ];
  }

  List<Widget> _buttonStyle() {
    return [
      DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          context.localizations!.one,
          context.localizations!.two,
          context.localizations!.free,
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      const SizedBox(width: 20),
      Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(context.localizations!.enabled),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: null,
            child: Text(
              context.localizations!.disable,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          OutlinedButton(
            onPressed: _showDialog,
            child: Text(
              context.localizations!.clickMe,
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: null,
            child: Text(
              context.localizations!.clickMe,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          TextButton(
            onPressed: _showDatePicker,
            child: Text(
              context.localizations!.enabled,
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: null,
            child: Text(
              context.localizations!.disable,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          FloatingActionButton(
            onPressed: _showTimePicker,
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(width: 10),
          const FloatingActionButton(
            onPressed: null,
            child: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
            ),
          ),
          const SizedBox(width: 10),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _switchesStyle() {
    return [
      Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Checkbox(
            value: false,
            onChanged: (value) {},
          ),
          const Checkbox(
            value: false,
            onChanged: null,
            tristate: false,
          ),
        ],
      ),
      Row(
        children: [
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (value) {},
          ),
          Radio(
            value: 2,
            groupValue: 1,
            onChanged: (value) {},
          ),
          const Radio(
            value: 1,
            groupValue: 1,
            onChanged: null,
          ),
        ],
      ),
      Row(
        children: [
          Switch(
            value: isSwitched,
            onChanged: (bool value) {
              setState(
                () {
                  isSwitched = value;
                },
              );
            },
          ),
          Switch(
            value: false,
            onChanged: (bool value) {},
          ),
          const Switch(
            value: true,
            onChanged: null,
          ),
        ],
      ),
      Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(
            () {
              _currentSliderValue = value;
            },
          );
        },
      ),
    ];
  }

  Widget _userNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: context.localizations!.username,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _passwordField() {
    final icon = _hidePassword ? Icons.visibility : Icons.visibility_off;
    return TextFormField(
      obscureText: _hidePassword,
      decoration: InputDecoration(
        labelText: context.localizations!.password,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
          icon: Icon(icon),
        ),
      ),
    );
  }

  Widget _errorField() {
    return TextFormField(
      validator: (v) => context.localizations!.somethingsWrong,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: context.localizations!.error,
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.localizations!.dialog),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.localizations!.close),
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}
