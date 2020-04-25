

import 'package:flutter/material.dart';
import './about.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MY APP'),
          backgroundColor: Color.fromARGB(100, 20, 12, 30),

        ),
        
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text('Ann'), 
                  accountEmail: new Text('anngresh07@gmail.com'),
                  currentAccountPicture: new CircleAvatar(
                   backgroundImage: new NetworkImage('https://ibb.co/87cqZg2'), 
                  ),
              ),
              new ListTile(
                title: new Text('About Page'),
                onTap: () {

                },
              ),
              new ListTile(
                title: new Text('Settings'),
                onTap: () {

                },
              ),

              new ListTile(
                title: new Text('Logout'),
                onTap: () {

                },
              )

            ],
          ),
        ),
        
      ),
    ),
  );

}