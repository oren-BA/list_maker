import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/MainPage.dart';

class ClickableAvatarWidget extends StatelessWidget {
  var user;
  var provider;
  MyHomePage homePage;

  ClickableAvatarWidget(this.user, this.provider, this.homePage);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    // title: Text("add List"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 2),
                        CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(user.photoURL),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Name: ' + user.displayName,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Email: ' + user.email,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            provider.logout();
                            Navigator.pop(context);
                          },
                          child: Text('Logout'),
                        )
                      ],
                    ),
                  );
                });
          },
          child: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(user.photoURL),
          )),
    );
  }
}
