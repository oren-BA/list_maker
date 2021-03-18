import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_maker/Pages/MainPage.dart';

class ErrorMessageWidget extends StatelessWidget {
  String errorMessage;
  StreamController<String> controller = StreamController.broadcast();

  ErrorMessageWidget(this.errorMessage, this.controller);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      title: Text("Error"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(errorMessage),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              controller.add("");
            },
            child: Text("OK"))
      ],
    );
  }
}
