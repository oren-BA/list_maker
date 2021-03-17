import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/main.dart';
import 'package:list_maker/Widgets/add_list_widget.dart';
import 'package:list_maker/Widgets/clickable_avatar_widget.dart';

class ListWidget extends StatefulWidget {
  var user;
  var provider;
  String title;
  MyHomePage homePage;
  List lists;

  ListWidget(this.user, this.provider, this.title, this.homePage);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  void initState() {
    super.initState();
    widget.homePage.refreshLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your lists"),
          actions: [
            ClickableAvatarWidget(widget.user, widget.provider, widget.homePage)
          ],
        ),
        body: ListView.builder(
          itemCount: widget.homePage.lists.length,
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
                key: Key(widget.homePage.lists[index]["list_name"]),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    margin: EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(widget.homePage.lists[index]["list_name"]),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          widget.homePage.removeList(widget.user, index);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.homePage.listPages[
                                  widget.homePage.lists[index]["list_name"]]),
                        );
                      },
                    )));
          },
        ),
        floatingActionButton:
            AddListWidget(widget.user, widget.homePage, this));
  }
}
