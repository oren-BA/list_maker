import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:list_maker/API/api_requests.dart';
import 'package:list_maker/Widgets/error_message_widget.dart';
import 'package:list_maker/Widgets/no_lists_widget.dart';
import 'package:list_maker/Widgets/signIn_widget.dart';
import 'package:list_maker/Widgets/list_widget.dart';
import 'package:list_maker/Widgets/loading_widget.dart';
import 'ListPage.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:list_maker/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List maker',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: MyHomePage('List maker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  List lists;
  StreamController<List> listController = StreamController.broadcast();
  final googleSignIn = GoogleSignIn();
  String inputList;
  Map<String, NewList> listPages;

  MyHomePage(String title) {
    this.title = title;
    this.listPages = {};
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();

  addList(final user, String inputList,
      StreamController<String> errorController) async {
    if (inputList == "") {
      return;
    }
    final idToken = await user.getIdToken(true);
    Response response = await listAction(idToken, 'add_list', inputList);
    if (response.body[0] != "[") {
      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      errorController.add(response.body);
      return;
    }
    lists = json.decode(response.body);
    listController.add(lists);
    listPages[inputList] = NewList(user, inputList, [], []);
  }

  removeList(final user, int index) async {
    final idToken = await user.getIdToken(true);
    Response response =
        await listAction(idToken, 'remove_list', lists[index]["list_name"]);
    lists = json.decode(response.body);
    listController.add(lists);
  }

  void refreshLists() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final idToken = await user.getIdToken(true);
    Response response = await getUserLists(idToken);
    lists = json.decode(response.body);
    for (var e in lists) {
      listPages[e["list_name"]] =
          NewList(user, e["list_name"], e["uncheckedItems"], e["checkedItems"]);
    }
    listController.add(lists);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    widget.refreshLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              final user = FirebaseAuth.instance.currentUser;
              if (snapshot.hasData) {
                widget.refreshLists();
                return StreamBuilder(
                  stream: widget.listController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || widget.lists == null) {
                      return LoadingWidget();
                    } else if (widget.lists.isNotEmpty) {
                      return ListWidget(user, provider, widget.title, widget);
                    } else {
                      return NoListWidget(
                          user, provider, widget.title, widget, this);
                    }
                  },
                );
              } else {
                return SignInWidget(provider, widget).build(context);
              }
            }),
      ),
    );
  }
}
