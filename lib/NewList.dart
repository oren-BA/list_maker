import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewList extends StatefulWidget {
  String name;
  List<String> items = [];
  List<String> checkedItems = [];

  NewList({Key key, this.name}) : super(key: key);

  @override
  HomePage createState() => HomePage();
// HomePage createState() => home;
}

class HomePage extends State<NewList> with AutomaticKeepAliveClientMixin {
  String inputItem = "";
  String inputCompany = "";
  String item;
  bool tapped;

  void addItem(String inputItem, String inputCompany) {
    setState(() {
      if (inputItem == "") {
        return;
      }
      String item;
      if (inputCompany == "") {
        item = "item:   " + inputItem;
      } else {
        item = "item:   " + inputItem + "      company:   " + inputCompany;
      }
      widget.items.add(item);
    });
  }

  void tappedCheck(int index) {
    setState(() {
      item = widget.items[index];
      widget.items.removeAt(index);
      widget.checkedItems.add(item);
    });
  }

  void tappedUncheck(int index) {
    setState(() {
      item = widget.checkedItems[index];
      widget.checkedItems.removeAt(index);
      widget.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(widget.items[index]),
                    child: Card(
                        // color: isTapped ? Colors.grey[300] : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        margin: EdgeInsets.all(4),
                        child: Container(
                          // color: ,
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: Text(widget.items[index]),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[300],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.items.removeAt(index);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        tappedCheck(index);
                                      },
                                    ),
                                  ])),
                        )));
              },
            ),
          ),
          Divider(
            thickness: 5,
            indent: 15,
            endIndent: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.checkedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(widget.checkedItems[index]),
                    child: Card(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        margin: EdgeInsets.all(4),
                        child: Container(
                          // color: ,
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: Text(widget.checkedItems[index]),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[300],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.checkedItems.removeAt(index);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        tappedUncheck(index);
                                      },
                                    ),
                                  ])),
                        )));
              },
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    title: Text("add item"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Item name'),
                          onChanged: (String itemName) {
                            inputItem = itemName;
                          },
                        ),
                        TextField(
                          decoration:
                              InputDecoration(labelText: 'Company name'),
                          onChanged: (String companyName) {
                            inputCompany = companyName;
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            addItem(inputItem, inputCompany);
                            inputItem = "";
                            inputCompany = "";
                            Navigator.of(context).pop();
                          },
                          child: Text("Add"))
                    ],
                  );
                });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
