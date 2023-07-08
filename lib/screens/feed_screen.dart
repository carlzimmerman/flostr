import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import '../models/nostr_client.dart';

class FeedScreen extends StatefulWidget {
  final String accountId;
  final NostrClient nostrClient;
  late Future<List<Map<String, dynamic>>> futureMessages;

  FeedScreen(this.accountId, this.nostrClient);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Map<String, dynamic>>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = widget.nostrClient.fetchMessages(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var message = snapshot.data![index];
                var content = message['content'];
                return ListTile(
                  title: Text(content),
                );
              },
            );
          }
        },
      ),
    );
  }
}
