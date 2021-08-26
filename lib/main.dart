// @dart=2.9

import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/choose_location.dart';
import 'pages/choose_area.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      initialRoute: '/',
      // onGenerateInitialRoutes: (String initialRouteName) {
      //   return [
      //     RouteSettings(name: '/'),
      //     navigator.widget.onGenerateRoute(
      //         RouteSettings(name: '/person', arguments: 'Chris')),
      //   ];
      // },
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
        '/area': (context) => ChooseArea(),
      }));
}
