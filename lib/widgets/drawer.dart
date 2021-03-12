import 'package:flutter/material.dart';
import 'package:shop_around_me/widgets/divider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      color: Colors.white,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Icon(
                      Icons.contact_support,
                      size: 100.0,
                    ),
                    // SizedBox(
                    //   width: 16.0,
                    // ),
                    Column(
                      children: [
                        Text("Ayiodelel"),
                        SizedBox(height: 6.0),
                        Text("PROFILE")
                      ],
                    )
                  ],
                ),
              ),
            ),
            DividerWidget(),
            SizedBox(
              height: 16.0,
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Visit Profile",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
             ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
             ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
