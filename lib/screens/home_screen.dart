import 'package:flutter/material.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> boards = [
    {'name': 'General', 'icon': Icons.chat},
    {'name': 'Announcements', 'icon': Icons.campaign},
    {'name': 'Help', 'icon': Icons.help},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Boards")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Message Boards'), onTap: () => Navigator.pushNamed(context, '/home')),
            ListTile(title: Text('Profile'), onTap: () => Navigator.pushNamed(context, '/profile')),
            ListTile(title: Text('Settings'), onTap: () => Navigator.pushNamed(context, '/settings')),
          ],
        ),
      ),
      body: ListView(
        children: boards.map((board) => ListTile(
          leading: Icon(board['icon']),
          title: Text(board['name']),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatScreen(boardName: board['name'])),
          ),
        )).toList(),
      ),
    );
  }
}
