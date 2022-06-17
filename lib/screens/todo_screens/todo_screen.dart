import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/auth/domain/auth_service.dart';
import 'package:flutter_theme/auth/screen/auth_screen.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/todo_screens/cubit/todo_cubit.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';
import 'package:get_it/get_it.dart';

class TodoScreen extends StatefulWidget {
  static const _routeName = '/todo-screen';

  static PageRoute<TodoScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => TodoCubit(),
          child: const TodoScreen(),
        );
      },
    );
  }

  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  AuthService get authService => GetIt.instance.get<AuthService>();
  @override
  void initState() {
    todoCubit.fromFirestore();
    super.initState();
  }

  TodoCubit get todoCubit => BlocProvider.of<TodoCubit>(context);
  String? note;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localizations!.todo),
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InputTitle(
                  onSaved: (value) {
                    note = value;
                  },
                  onPressed: _onPressedSave,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: state.listTitle?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      List<Todo> todo = state.listTitle ?? [];
                      bool isComplete = todo[index].complete;
                      return ListTile(
                        leading: Checkbox(
                          value: isComplete,
                          onChanged: (bool? value) {
                            todoCubit.updateTodo(todo[index].id, !isComplete);
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => ChangeTodo(
                                    onPressed: (noteChanged) {
                                      todoCubit.changeNote(
                                        noteChanged,
                                        todo[index].id,
                                      );
                                    },
                                    noteChanged: todo[index].note,
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: (() {
                                todoCubit.deleteTodo(todo[index].id);
                              }),
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        ),
                        title: Text(todo[index].note),
                      );
                    },
                  ),
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    authService.logOut();
                    Navigator.pushReplacement(context, AuthScreen.route);
                  },
                  child: const Icon(Icons.logout_outlined),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPressedSave(GlobalKey<FormState> _formKey) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      todoCubit.addNote(note!);
      todoCubit.fromFirestore();
    }
  }
}

class InputTitle extends StatelessWidget {
  InputTitle({
    Key? key,
    required this.onSaved,
    required this.onPressed,
  }) : super(key: key);
  final ValueChanged<String?> onSaved;
  final ValueChanged<GlobalKey<FormState>> onPressed;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onSaved: onSaved,
              validator: validate,
              decoration: InputDecoration(
                hintText: context.localizations!.enterTitle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => onPressed(_formKey),
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'something error';
    }
    return null;
  }
}

// ignore: must_be_immutable
class ChangeTodo extends StatelessWidget {
  ChangeTodo({
    Key? key,
    required this.onPressed,
    required this.noteChanged,
  }) : super(key: key);

  final ValueChanged<String> onPressed;
  String noteChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(context.localizations!.editCase),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: noteChanged,
            onChanged: (text) {
              noteChanged = text;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(context.localizations!.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(context.localizations!.change),
          onPressed: () {
            onPressed(noteChanged);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
