import 'package:flutter/material.dart';
import 'package:m9_news/utils/constants.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M9 Asia',
      theme: ThemeData(
        primaryColor: AppConstants.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppConstants.primaryColor,
          secondary: AppConstants.accentColor,
        ),
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // textTheme: const TextTheme(
        //   headline6: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     color: AppConstants.textColor,
        //   ),
        //   bodyText2: TextStyle(fontSize: 16, color: AppConstants.textColor),
        // ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
