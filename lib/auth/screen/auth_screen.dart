import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/auth/screen/cubit/auth_cubit.dart';
import 'package:flutter_theme/infrastructure/theme/app_images.dart';
import 'package:flutter_theme/screens/todo_screens/todo_screen.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';

class AuthScreen extends StatefulWidget {
  static const _routeName = '/auth';

  static PageRoute<AuthScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: const AuthScreen(),
        );
      },
    );
  }

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  AuthCubit get authCubit => BlocProvider.of<AuthCubit>(context);
  String? email;
  String? password;
  bool isPasswordVisible = false;
  bool isPasswordVisibleReg = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          Navigator.pushReplacement(context, TodoScreen.route);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localizations!.authentication),
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
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: context.localizations!.exit.toUpperCase(),
                ),
                Tab(
                  text: context.localizations!.registration.toUpperCase(),
                ),
              ],
            ),
          ),
          body: Form(
            key: _formKey,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Exit(
                  onSavedEmail: (value) {
                    email = value;
                  },
                  onSavedPassword: (value) {
                    password = value;
                  },
                  onPressed: _onPressedSave,
                  validate: validate,
                  isVisible: isPasswordVisible,
                  onShow: (value) {
                    setState(
                      () {
                        isPasswordVisible = !value;
                      },
                    );
                  },
                  onPressedGoogle: _onPressedSaveGoogle,
                ),
                Registration(
                  onSavedEmail: (value) {
                    email = value;
                  },
                  onSavedPassword: (value) {
                    password = value;
                  },
                  validate: validate,
                  isVisibleReg: isPasswordVisibleReg,
                  onShow: (value) {
                    setState(
                      () {
                        isPasswordVisibleReg = !value;
                      },
                    );
                  },
                  onPressed: _onPressedSaveRegistration,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'something error';
    }
    return null;
  }

  void _onPressedSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authCubit.signIn(email!, password!);
    }
  }

  void _onPressedSaveRegistration() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authCubit.createAccount(email!, password!);
    }
  }

  void _onPressedSaveGoogle() {
    authCubit.signInWithGoogle();
  }
}

class Exit extends StatelessWidget {
  const Exit({
    Key? key,
    required this.onSavedEmail,
    required this.onSavedPassword,
    required this.onPressed,
    this.validate,
    required this.isVisible,
    required this.onShow,
    required this.onPressedGoogle,
  }) : super(key: key);
  final ValueChanged<String?> onSavedEmail;
  final ValueChanged<String?> onSavedPassword;
  final String? Function(String?)? validate;
  final bool isVisible;
  final ValueChanged<bool> onShow;
  final void Function()? onPressed;
  final void Function()? onPressedGoogle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            validator: validate,
            onSaved: onSavedEmail,
            decoration: InputDecoration(
              hintText: context.localizations!.eMail,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: validate,
            onSaved: onSavedPassword,
            obscureText: !isVisible,
            decoration: InputDecoration(
              hintText: context.localizations!.password,
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  onShow(isVisible);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                context.localizations!.enter.toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(context.localizations!.orSignInWithYourAccount),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onPressedGoogle,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                    child: Image.asset(AppImages.google),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context.localizations!.google.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Registration extends StatelessWidget {
  const Registration({
    Key? key,
    required this.onSavedEmail,
    required this.onSavedPassword,
    this.validate,
    required this.isVisibleReg,
    required this.onShow,
    required this.onPressed,
  }) : super(key: key);
  final ValueChanged<String?> onSavedEmail;
  final ValueChanged<String?> onSavedPassword;
  final String? Function(String?)? validate;
  final bool isVisibleReg;
  final ValueChanged<bool> onShow;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            onSaved: onSavedEmail,
            validator: validate,
            decoration: InputDecoration(
              hintText: context.localizations!.eMail,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            onSaved: onSavedPassword,
            validator: validate,
            decoration: InputDecoration(
              hintText: context.localizations!.password,
              suffixIcon: IconButton(
                icon: Icon(
                  isVisibleReg ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  onShow(isVisibleReg);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                context.localizations!.toRegister.toUpperCase(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
