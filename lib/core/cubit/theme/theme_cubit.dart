import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDark: true));

  void toggleTheme() {
    emit(ThemeState(isDark: !state.isDark));
  }
}
