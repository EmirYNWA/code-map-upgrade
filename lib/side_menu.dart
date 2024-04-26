import 'package:code_map/help.dart';
import 'package:code_map/login.dart';
import 'package:code_map/search_screen/searchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'package:code_map/favorites_page/favoritePage.dart';

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
                MaterialPageRoute(builder: (context) => const HomePage()),
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
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
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
                "Pretraži", style: TextStyle(
              fontFamily: 'Poppins',)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritePage()));
            },
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                CupertinoIcons.heart,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LogIn()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LogIn()));
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


