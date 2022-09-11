import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speechless/app_routes.dart';
import 'package:speechless/app_spacing.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key, required this.route}) : super(key: key);

  final String route;

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  late Socket crSocket;
  bool loading = false;
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text(
                  'enter an IP \nto ' + widget.route.replaceAll("/", "") + ' room',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 34,
                  ),
                ),
                SizedBox(height: AppSpacing.M,),
                const Text(
                  'note: this is a debug-feature - in future servers will be shown here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 2 * AppSpacing.XXL,),
          Center(
            child: SizedBox(
              width: 250,
              child: TextField(
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: "0.0.0.0:0000",
                  contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )
                ),
                controller: _ipController,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.L,),
          !loading 
          ? OutlinedButton(
              child: const Text('connect!'),
              onPressed: () async {
                setState(() {
                  loading = true;
                });

                crSocket = await Socket.connect(_ipController.text.split(":")[0], int.parse(_ipController.text.split(":")[1]));

                setState(() {
                  loading = false;
                });

                if(widget.route == AppRoutes.host) {
                  crSocket.add(utf8.encode("##host##"));
                }

                Navigator.of(context).pushNamed(widget.route, arguments: crSocket); 
              },
              style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.black, width: 1)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
            )
          : const CircularProgressIndicator(
            color: Colors.black,
          ),
          const Spacer(flex: 1,),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: 0.1,
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                ),
                GestureDetector(
                  child: const Text("Zurück"),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}