import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'locale_state.dart';

@injectable
@lazySingleton
class LocaleCubit extends Cubit<LocaleState> {
  static const String _localeKey = 'app_locale';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(const LocaleState(locale: Locale('en', ''))) {
    _loadLocale();
  }

  void _loadLocale() {
    final localeString = _prefs.getString(_localeKey);
    if (localeString != null) {
      final parts = localeString.split('_');
      final locale = Locale(parts[0], parts.length > 1 ? parts[1] : '');
      emit(LocaleState(locale: locale));
    }
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_localeKey, '${locale.languageCode}_${locale.countryCode}');
    emit(LocaleState(locale: locale));
  }

  Future<void> toggleLocale() async {
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('my', '')
        : const Locale('en', '');
    await setLocale(newLocale);
  }
}
