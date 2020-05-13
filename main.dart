// code for fetch data using REST API
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=> runApp(new MaterialApp(
  home:  new HomePage(),

));

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url ="http://122.165.154.111:8081/hrms/v1/leaveblanc/";
  List item;
  var item1;
  @override
   // popup menu button item
   GlobalKey<ScaffoldState> _scaff= new GlobalKey<ScaffoldState>();
    static const _popItem= <String> [
    "Leave Apply",
    "Leave Cancel",
    "Leave History",
    "Logout"
  ];
  static List<PopupMenuItem<String>> _pop= _popItem.map((String val)=>
      PopupMenuItem<String>(
        value: val,
        child: Text(val),
      )
  ).toList();

  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept":"application/json"}
    );
    //print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      item1 = convertDataToJson['response'];

      print(item1);
      item = item1['payload']['data'];
      print(item);
    });

    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaff,
      appBar: new AppBar(
        title: new Text("Leave Status"),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (String val){
                val= val;
                _scaff.currentState.showSnackBar(
                  SnackBar(content: Text(val)),
                );
              },
              itemBuilder:(BuildContext context)=> _pop)
        ],
      ),
      body: new ListView.builder(
        itemCount: item== null ? 0: item.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new Text(item[index]["lvtyp"]),
                          subtitle: new Text(item[index]["blnc"]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

