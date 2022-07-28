// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:linux_app/model/task.dart';

import '../model/task.dart';

// ignore: must_be_immutable
class DashBoard extends StatefulWidget {
  String? name;
  DashBoard(this.name, {Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool signout = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formSubKey = GlobalKey();
  final _name = TextEditingController();
  final _subname = TextEditingController();
  List<Task> data = [];

  String? _validateName(String? value) {
    return value!.isEmpty ? 'name is Invaild' : null;
  }

  String? _validatesubtaskName(String? value) {
    return value!.isEmpty ? 'name is Invaild' : null;
  }

  void _signout(BuildContext context) async {
    Widget yesButton = TextButton(
      onPressed: () => setState(() {
        signout = true;
        Navigator.pop(context);
      }),
      child: Text("Yes"),
    );
    Widget noButton = TextButton(
        onPressed: () => setState(() {
              signout = false;
              Navigator.pop(context);
            }),
        child: Text("No"));

    AlertDialog _alert = AlertDialog(
      title: Text("Sign out"),
      content: Text('Are you sure you want to Sign out?'),
      actions: [yesButton, noButton],
    );
    await showDialog(
        context: context,
        builder: (context) {
          return _alert;
        });
    if (signout) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, "Sign out");
    }
  }

  void addSubTask(id) {
    if (_formSubKey.currentState!.validate()) {
      Random random = Random();
      int randomNumber = random.nextInt(100);
      var item = data.firstWhere((element) => element.id == id);
      setState(() {
        item.sublist = [
          ...item.sublist!,
          SubTask(id: randomNumber, name: _subname.text, like: false)
        ];
      });
      _subname.clear();
      Navigator.pop(context);
    }
  }

  void deleteSub(taskid, subtaskid) {
    if (subtaskid != null) {
      var task = data.firstWhere((element) => element.id == taskid);
      var subtaskIndex =
          task.sublist!.indexWhere((element) => element.id == subtaskid);
      setState(() {
        task.sublist!.removeAt(subtaskIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_interpolation_to_compose_strings
      appBar: AppBar(
        title: Text('Welcome ' + widget.name!),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => _signout(context), icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _name,
                        validator: (value) => _validateName(value),
                        decoration: InputDecoration(
                          hintText: "Enter name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: "Enter name",
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Random random = Random();
                            setState(() {
                              int randomNumber = random.nextInt(100);
                              data = [
                                ...data,
                                Task(
                                    id: randomNumber,
                                    name: _name.text,
                                    sublist: [])
                              ];
                            });
                            _name.clear();
                          }
                        },
                        child: Text("Add"),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              taskcontainer(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Card(
                    color: Colors.amber,
                    child: Stack(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Image(
                          width: 40.0,
                          image:
                              AssetImage('resources/images/comfortfoods.jpg'),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container taskcontainer() {
    return Container(
      constraints: BoxConstraints(maxHeight: double.infinity),
      child: data.isEmpty == true
          ? SizedBox(
              width: double.infinity,
              child: Center(
                child: Text("No List found"),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                data[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                subtaskmodal(context, _formSubKey, _subname,
                                    data[index].id);
                              },
                              child: Text("Add"))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data[index].sublist!.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                                child: ListTile(
                                  title: Text(
                                      data[index].sublist![i].name.toString()),
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LikeButton(
                                        onTap: (isLiked) {
                                          return changedata(
                                              isLiked,
                                              data[index].id,
                                              data[index].sublist![i].id);
                                        },
                                        isLiked: data[index].sublist![i].like,
                                        size: 24.0,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteSub(data[index].id,
                                              data[index].sublist![i].id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ]),
                  ),
                );
              }),
    );
  }

  Future<dynamic> subtaskmodal(BuildContext context, formkey, subname, id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add Sub Task'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: subname,
                      validator: (value) => _validatesubtaskName(value),
                      decoration: InputDecoration(
                        labelText: 'Sub Task Name',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _subname.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addSubTask(id);
                      },
                      child: Text("Add"))
                ],
              )
            ],
          );
        });
  }

  Future<bool> changedata(bool isLiked, id, sid) async {
    if (sid != null) {
      var task = data.firstWhere((element) => element.id == id);
      var subtaskIndex =
          task.sublist!.firstWhere((element) => element.id == sid);
      setState(() {
        subtaskIndex.like = !isLiked;
      });
    }
    return !isLiked;
  }
}
