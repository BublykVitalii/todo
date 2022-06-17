// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../auth/api/http_auth.repository.dart' as _i8;
import '../auth/domain/auth_repository.dart' as _i7;
import '../auth/domain/auth_service.dart' as _i9;
import '../screens/api/firebase_todo_repository.dart' as _i5;
import '../screens/domain/todo_repository.dart' as _i4;
import '../screens/domain/todo_service.dart' as _i6;
import '../utils/store_interaction.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.StoreInteraction>(_i3.StoreInteraction());
  gh.singleton<_i4.TodoRepository>(
      _i5.FirebaseTodoRepository(get<_i3.StoreInteraction>()));
  gh.singleton<_i6.TodoService>(_i6.TodoService(get<_i4.TodoRepository>()));
  gh.singleton<_i7.AuthRepository>(
      _i8.HttpAuthRepository(get<_i3.StoreInteraction>()));
  gh.singleton<_i9.AuthService>(_i9.AuthService(get<_i7.AuthRepository>()));
  return get;
}
