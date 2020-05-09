
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<Leave> fetchLeave() async {
  final response =
  await http.get('http://122.165.154.111:8081/hrms/v1/leaveblanc/');

  if (response.statusCode == 200) {
    return Leave.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load the page');
  }
}

class Leave {
  final int userId;
  final double blnc;
  final String lvtyp;
  final List<dynamic> lvlist;

  Leave({this.userId,this.blnc,this.lvtyp,this.lvlist});

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
   userId: json['userId'],
    blnc: json['blnc'],
    lvtyp: json['lvtyp'],
    );

  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Leave> getLeavedtls;
  @override
  void initState() {
    super.initState();
    getLeavedtls = fetchLeave();
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _scaff,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Leave Status'),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              //IconButton(
              // onPressed: (){},
              //icon: Icon(Icons.more_vert),
              //)
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
          body:
          Center(
            child: FutureBuilder<Leave>(
              future: getLeavedtls,
             builder: (context,snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                      itemBuilder: (context,index){
                        return ListTile(
                            title: Text(snapshot.data.lvlist[index][0]),
                         subtitle: Text(snapshot.data.lvlist[index][1]),
                        );
                      }
                      );

                 //return Text(snapshot.data.lvtyp ?? 'default value');
               } else if (snapshot.hasError){
                 return Text("${snapshot.error}");
               }
               return CircularProgressIndicator();
             },
            ),
          )
      ),
    );
  }
}

