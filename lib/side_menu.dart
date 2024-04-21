import 'package:code_map/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
                accountName: Text('Kristina Josipović',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.black),),
                accountEmail: Text('kristinajosipovic21@gmail.com',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.black),),
                decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.green],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.home,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Početna", style: TextStyle(
              fontFamily: 'Poppins',)),

          ),
          /*ListTile(
            onTap: () {

            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.search,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Search", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),*/
          ListTile(
            onTap: () {
              print('Widget je dodirnut!');
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.star,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Omiljeni", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
          ListTile(
            onTap: () {
              print('Widget je dodirnut!');
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.chat_bubble_text,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Pomoć", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
              });
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.person_crop_circle,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Račun", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
              });
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.logout,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Odjavite se", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              SystemNavigator.pop();
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 25,
              ),
            ),
            title: const Text(
                "Izlazak", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
        ],
      ),

    );

  }
}


