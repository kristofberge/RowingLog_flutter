import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rowing Log"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(color: Colors.orange),
            ),
            ListTile(
              title: Text('Strava'),
              onTap: () => Navigator.pushNamed(context, '/strava'),
            ),
            ListTile(
              title: Text('Concept 2'),
              onTap: () => Navigator.pushNamed(context, '/concept2'),
            )
          ],
        ),
      ),
      body: Center(
        child: Text('This is the home page'),
      ),
    );
  }
}
