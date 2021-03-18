import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/MainPage.dart';
import 'package:list_maker/Widgets/add_list_widget.dart';
import 'package:list_maker/Widgets/clickable_avatar_widget.dart';
import 'package:list_maker/config.dart';

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


  void tapOnList(int index){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget.homePage.listPages[
          widget.homePage.lists[index][CONFIG.list_name]]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(CONFIG.list_page_title),
          actions: [
            ClickableAvatarWidget(widget.user, widget.provider, widget.homePage)
          ],
        ),
        body: ListView.builder(
          itemCount: widget.homePage.lists.length,
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
                key: Key(widget.homePage.lists[index][CONFIG.list_name]),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    margin: EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(widget.homePage.lists[index][CONFIG.list_name]),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                        ),
                        onPressed: () {
                          widget.homePage.removeList(widget.user, index);
                        },
                      ),
                      onTap: () {
                        tapOnList(index);
                      },
                    )));
          },
        ),
        floatingActionButton:
            AddListWidget(widget.user, widget.homePage, this));
  }
}
