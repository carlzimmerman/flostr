import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'dart:math';
import 'package:convert/convert.dart';

class FeedScreen extends StatefulWidget {
  final String accountId;

  FeedScreen(this.accountId);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  StreamSubscription? subscription;
  late NostrEventsStream nostrEventsStream;
  List<NostrEvent> events = [];

  String generateHex(int length) {
    Random random = Random();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    return hex.encode(values);
  }

  @override
  void initState() {
    super.initState();
    Nostr.instance.enableLogs();
    Nostr.instance.relaysService.init(
      relaysUrl: ["wss://relay.damus.io", "wss://offchain.pub"],
    ).then((_) {
      final request = NostrRequest(
        subscriptionId: generateHex(32), // generates a 64-character hexadecimal string
        filters: [
          NostrFilter(
            kinds: [1],
            authors: [widget.accountId],
          ),
        ],
      );
      nostrEventsStream = Nostr.instance.relaysService.startEventsSubscription(request: request);
      subscription = nostrEventsStream.stream.listen((event) {
        setState(() {
          events.add(event);
        });
      });
    });
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
      Nostr.instance.relaysService.closeEventsSubscription(nostrEventsStream.subscriptionId);
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var event = events[index];
          var content = event.content;
          return ListTile(
            title: Text(content),
          );
        },
      ),
    );
  }
}