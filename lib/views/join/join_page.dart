import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:speechless/app_spacing.dart';
import 'package:translator/translator.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key, required this.socket}) : super(key: key);

  final Socket socket;

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final translator = GoogleTranslator();

  String _currentLanguageCode = "de";
  String _text = "waiting for text...";
  bool _firstSentence = true;

  final double _maxHeight = 275;
  
  List<String> itemList = <String>['german', 'english',];
  String dropdownValue = 'german';

  @override
  void initState() {
    widget.socket.listen((Uint8List data) async {
      if(_firstSentence) {
        _text = "";
        _firstSentence = false;
      }
      var translation = await translator.translate(utf8.decode(data), to: _currentLanguageCode, from: "de");
      _text += ' ' + translation.text + '\n\n';
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.XXL,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('you are connected to '),
                  Text(
                    widget.socket.remoteAddress.address + ':' + widget.socket.remotePort.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: AppSpacing.M,),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                  switch(value) {
                    case "german":
                      _currentLanguageCode = "de";
                      break;
                    case "english":
                      _currentLanguageCode = "en";
                      break;
                  }
                });
              },
              items: itemList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: SizedBox(
                height: _maxHeight,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        tileMode: TileMode.mirror,
                        colors: [Colors.purple, Colors.transparent,],
                        stops: [0.0, 0.2,], // 10% purple, 80% transparent, 10% purple
                      ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstOut,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Column(
                      children: [
                        Text(
                          _text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: AppSpacing.XL,)
                      ],
                    )
                  ),
                ),
              )
            ),
            const Spacer(flex: 2,),
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
                    onTap: () {
                      widget.socket.close();
                      Navigator.of(context).pop();
                    },
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