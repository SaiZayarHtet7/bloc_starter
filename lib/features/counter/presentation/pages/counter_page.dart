import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/counter_cubit.dart';
import '../widgets/counter_display.dart';
import '../widgets/counter_controls.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CounterCubit>(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterTitle),
        actions: [
          // Language Switcher
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              final isEnglish = localeState.locale.languageCode == 'en';
              return IconButton(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language),
                    const SizedBox(width: 4),
                    Text(
                      isEnglish ? 'EN' : 'MY',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                tooltip: isEnglish ? 'Switch to Myanmar' : 'Switch to English',
                onPressed: () {
                  context.read<LocaleCubit>().toggleLocale();
                },
              );
            },
          ),
          // Theme Switcher
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (mode) {
              context.read<ThemeCubit>().setThemeMode(mode);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    const Icon(Icons.light_mode),
                    const SizedBox(width: 8),
                    Text(l10n.lightTheme),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode),
                    const SizedBox(width: 8),
                    Text(l10n.darkTheme),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    const Icon(Icons.settings_system_daydream),
                    const SizedBox(width: 8),
                    Text(l10n.systemTheme),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          if (state is CounterLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CounterError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterCubit>().loadCounter();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CounterLoaded) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterDisplay(value: state.counter.value),
                    const SizedBox(height: 32),
                    CounterControls(
                      onIncrement: () {
                        context.read<CounterCubit>().increment();
                      },
                      onDecrement: () {
                        context.read<CounterCubit>().decrement();
                      },
                      onReset: () {
                        context.read<CounterCubit>().reset();
                      },
                    ),
                    const SizedBox(height: 32),
                    OutlinedButton.icon(
                      onPressed: () {
                        context.go('/posts');
                      },
                      icon: const Icon(Icons.article),
                      label: const Text('View Posts'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
