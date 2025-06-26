import 'package:flutter/material.dart';

class ListTileScreen extends StatelessWidget {
  const ListTileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListTile demo")),
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("A"),
            ),
            title: Text("username"),
            subtitle: Text("DC: Hà Nội"),
            trailing: Icon(Icons.call),
            onTap: () {
              print("object");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text("nvn@gmail.com"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            title: Text('Chế độ tối'),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
        ],
      ),
    );
  }
}
