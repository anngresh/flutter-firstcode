import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=> runApp(new MaterialApp(
  home:  new HomePage(),
  
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url ="http://122.165.154.111:8081/hrms/v1/leaveblanc/";
  List data;
  @override

  void initState() {       // this method call first when creating widget
    super.initState();
    this.getJsonData();   // to load json data
  }

   Future<String> getJsonData() async{            //to get json data
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      //only accept json response not apart anything from json like xml
      headers: {"Accept":"application/json"}
    );
     print(response.body);        //print the value to console

     setState(() {              // its a method
       var convertDataToJson = json.decode(response.body);
       data = convertDataToJson['payload'];
     });

     return "Sucess";

   }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Leave Status"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0: data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['lvtyp']),
                      padding: const EdgeInsets.all(20.0),
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


