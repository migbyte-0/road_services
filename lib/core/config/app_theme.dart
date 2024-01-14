import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.blueAccent, // A secondary color for your app.
    scaffoldBackgroundColor:
        Colors.white, // The default color of MaterialType.canvas.
    textTheme: const TextTheme(
      // The text themes that describe the typography styles.
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic,
          color: Colors.deepPurple),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      // Default values for the AppBar's ThemeData.
      color: Colors.transparent,
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      ).titleLarge,
    ),
    buttonTheme: const ButtonThemeData(
      // Defines the default configuration of button widgets.
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ),
    cardTheme: CardTheme(
      // Default values for Material's CardTheme.
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    iconTheme: const IconThemeData(
      // Default values for IconThemeData.
      color: Colors.green,
      opacity: 0.8,
      size: 20,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
  );
}
