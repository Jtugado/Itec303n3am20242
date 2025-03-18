import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  static const routeName = '/chat-detail';

  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatPartnerName = ModalRoute.of(context)?.settings.arguments as String?;

    final List<String> messages = [
      "Hi there, I'm interested in your donation!",
      "Hello! Which items are you looking for?",
      "I'm looking for a few books you posted.",
      "Sure, let's arrange a pickup time.",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(chatPartnerName ?? "Chat Detail"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Align(
                  alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMine
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Send message
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
