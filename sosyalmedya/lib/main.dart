import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sosyalmedya/screens/boarding_screen.dart';
import 'package:sosyalmedya/screens/home_screen.dart';
import 'package:sosyalmedya/screens/myfriends_screen.dart';
import 'package:sosyalmedya/screens/myposts_screen.dart';
import 'package:sosyalmedya/screens/splash_screen.dart';
import 'drawer.dart';
import 'darkmode_provider.dart';
import 'language_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkModeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer2<DarkModeProvider, LanguageProvider>(
        builder: (context, darkModeProvider, languageProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: languageProvider.isEnglish ? 'Social Media' : 'SosyalMedya',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: darkModeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          drawer: MyDrawer(),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/boarding',
          builder: (context, state) => BoardingScreen(),
        ),
        GoRoute(
          path: '/myfriends',
          builder: (context, state) => MyFriendsScreen(),
        ),
        GoRoute(
          path: '/myposts',
          builder: (context, state) => MyPostsScreen(),
        ),
      ],
    ),
  ],
);
