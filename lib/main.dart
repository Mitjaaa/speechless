import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speechless/views/home/home_page.dart';

void main() {
  runApp(
      /*MultiProvider(
        providers: [],
        child: const ConnectApp(),
      )*/
      const SpeechlessApp()
  );
}

class SpeechlessApp extends StatelessWidget {
  const SpeechlessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'speech:less',
      theme: ThemeData(
          backgroundColor: Colors.white
      ),

      // add scrollbehavior for web
      scrollBehavior: kIsWeb ? ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          // Allows to swipe in web browsers
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse
        },
        scrollbars: false,
        overscroll: false,
      ) : null,

      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage());

        }
        /*else if (settings.name == '/search') {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => SearchPage(input: settings.arguments as String));

        } else if (settings.name == '/details') {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => DetailsPage(index: settings.arguments as int));
        }*/

        return null;
      },
    );
  }
}