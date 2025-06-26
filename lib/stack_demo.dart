import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  const StackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("stack")),
      body: Stack(
        children: [
          Container(width: 300, height: 300, color: Colors.blue),
          Container(width: 200, height: 200, color: Colors.green),
          Positioned(
            top: 20,
            left: 20,
            child: Icon(Icons.star, size: 50, color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}
