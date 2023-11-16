import 'package:flutter_bloc/flutter_bloc.dart';

class AppthemeCubit extends Cubit<bool> {
  AppthemeCubit() : super(false);

  bool _isDark = false;
  bool get isDark => _isDark;

  Future<void> init() async {
    _isDark = !_isDark;
    emit(_isDark);
  }
}
