import 'package:flutter/material.dart';

class SortListScreen extends StatelessWidget {
  const SortListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sort List")),
      body: ListView(
        children: [
          Text("Item 1"),
          Text("Item 2"),
          Text("Item 3"),
          Text("Item 4"),
          Text("Item 5"),
          Text("Item 6"),
        ],
      ),
    );
  }
}

class LongListScreen extends StatelessWidget {
  const LongListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Long List")),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
    );
  }
}

class DividerListScreen extends StatelessWidget {
  const DividerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Divider List")),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(title: Text("data $index"));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 10,
      ),
    );
  }
}

class HorizontalScreen extends StatelessWidget {
  const HorizontalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Horizontal Screen")),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: EdgeInsets.all(8),
            child: Center(
              child: Text('Item $index', style: TextStyle(color: Colors.black)),
            ),
          );
        },
      ),
    );
  }
}
