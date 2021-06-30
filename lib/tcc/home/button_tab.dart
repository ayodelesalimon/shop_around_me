import 'package:flutter/material.dart';
import 'package:shop_around_me/tcc/home/tabs/connect.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          print("home");
          // Navigator.pushNamed(context, "/first");
          break;
        case 1:
         print("homggggge");
         Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, _, __) => Connect()),
                            );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: "Home",
          ),
          BottomNavigationBarItem(
            label: "Connect",
            icon: Icon(Icons.people, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            label: "Give",
            icon: Icon(Icons.favorite_outline, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            label: "Media",
            icon: Icon(Icons.video_call, color: Colors.blue),
          ),
          BottomNavigationBarItem(
            label: "Events",
            icon: Icon(Icons.calendar_view_day_sharp, color: Colors.blue),
          ),
        ],
        // type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 20,
        onTap: _onItemTapped,
        elevation: 5);
  }
}
