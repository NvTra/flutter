import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tabar Demo"),
          bottom: TabBar(
            indicatorColor: Colors.yellow, //màu gạch chân
            labelColor: Colors.red,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Home Page')),
            Center(child: Text('Search Page')),
            Center(child: Text('Profile Page')),
          ],
        ),
      ),
    );
  }
}
