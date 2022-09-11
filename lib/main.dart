import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speechless/app_routes.dart';
import 'package:speechless/provider/navigation_provider.dart';
import 'package:speechless/views/connect/connect_page.dart';
import 'package:speechless/views/home/home_page.dart';
import 'package:speechless/views/host/host_page.dart';
import 'package:speechless/views/join/join_page.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationIndex()),
        ],
        child: const SpeechlessApp(),
      )
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
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse
        },
        scrollbars: false,
        overscroll: false,
      ) : null,

      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.home) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage());

        } else if (settings.name == AppRoutes.connect) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => ConnectPage(route: settings.arguments! as String));

        } else if (settings.name == AppRoutes.join) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => JoinPage(socket: settings.arguments! as Socket));

        } else if (settings.name == AppRoutes.host) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) => HostPage(socket: settings.arguments! as Socket));
        }

        return null;
      },
    );
  }
}