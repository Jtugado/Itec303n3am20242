import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> chats = const [
    {
      'name': 'John Doe',
      'message': 'Hi, I\'m interested in your donation.',
      'time': '10:30 AM'
    },
    {
      'name': 'Jane Smith',
      'message': 'When can we schedule a pickup?',
      'time': 'Yesterday'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  chat['name']!.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(chat['name']!),
              subtitle: Text(chat['message']!),
              trailing: Text(chat['time']!),
              onTap: () {
                Navigator.of(context).pushNamed(
                  ChatDetailScreen.routeName,
                  arguments: chat['name'],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
