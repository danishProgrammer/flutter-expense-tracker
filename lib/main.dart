import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColor =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // to ensure that orientation is locked by the system.
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) => {
            runApp(MaterialApp(
              darkTheme: ThemeData.dark().copyWith(
                colorScheme: darkColorScheme,
                cardTheme: const CardTheme().copyWith(
                    color: darkColorScheme.secondaryContainer,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8)),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: darkColorScheme.primaryContainer)),
              ),
              theme: ThemeData().copyWith(
                  scaffoldBackgroundColor:
                      const Color.fromARGB(255, 216, 232, 238),
                  colorScheme: kColor,
                  appBarTheme: const AppBarTheme().copyWith(
                      backgroundColor: kColor.onPrimaryContainer,
                      foregroundColor: kColor.primaryContainer),
                  cardTheme: const CardTheme().copyWith(
                      color: kColor.secondaryContainer,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8)),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kColor.primaryContainer)),
                  textTheme: const TextTheme().copyWith(
                      titleLarge: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: kColor.onSecondaryContainer,
                          fontSize: 14))),
              themeMode: ThemeMode.dark,
              home: const Expenses(),
            ));
          // });
}
