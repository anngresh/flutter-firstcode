import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          body: ListView(children: <Widget>[
            DataTable(
              columns: [
                DataColumn(label: Text('Leave')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Balance')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('CL')),
                  DataCell(Text('20')),
                  DataCell(Text('6')),
                ]),
                DataRow(cells: [
                  DataCell(Text('EL')),
                  DataCell(Text('90')),
                  DataCell(Text('49')),
                ]),
                DataRow(cells: [
                  DataCell(Text('SL')),
                  DataCell(Text('12')),
                  DataCell(Text('8')),
                ]),
              ],
            ),
          ])),
    );
  }
}

