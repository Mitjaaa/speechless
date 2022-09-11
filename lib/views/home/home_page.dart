import 'package:flutter/material.dart';
import 'package:speechless/app_routes.dart';
import 'package:speechless/app_spacing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "speech",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ":less",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: AppSpacing.S,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Text(
                  "one app - many languages...\n\n       join a room to listen\n   or host a room to speak",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSpacing.XXL,
            ),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 100),
              height: 25,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.connect, arguments: AppRoutes.join),
                child: const Text("join room"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 25)),
                  maximumSize: MaterialStateProperty.all(const Size(200, 25)),
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.black, width: 1)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: AppSpacing.L,
            ),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 100),
              height: 25,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed(AppRoutes.connect, arguments: AppRoutes.host),
                child: const Text("host room"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 25)),
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.black, width: 1)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
          ],
        ),
      resizeToAvoidBottomInset: false,
    );
  }
}