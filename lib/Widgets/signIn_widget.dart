import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_maker/Pages/MainPage.dart';

class SignInWidget extends StatelessWidget {

  var provider;
  MyHomePage homePage;
  SignInWidget(this.provider, this.homePage);

  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 90,
                child: Text(
                  'My List Maker',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(4),
              child: OutlineButton.icon(
                label: Text(
                  'Sign In With Google',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                highlightedBorderColor: Colors.black,
                borderSide: BorderSide(color: Colors.black),
                textColor: Colors.black,
                icon: FaIcon(Icons.add, color: Colors.red),
                onPressed: () {
                  provider.login();
                },
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Login to continue',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}