import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true); // true = dark mode, false = light mode

  void toggleTheme() {
    emit(!state);
  }

  bool get isDarkMode => state;
}
