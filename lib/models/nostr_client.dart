import 'dart:convert';
import 'package:web_socket_channel/io.dart';


class NostrClient {
  final List<String> relays;

  NostrClient(this.relays);

  Future<List<Map<String, dynamic>>> fetchMessages(String accountId) async {
    var channel = IOWebSocketChannel.connect('wss://atlas.nostr.land');
    var messages = <Map<String, dynamic>>[];

    channel.sink.add(jsonEncode({
      't': 'sub',
      'id': accountId,
    }));

    await for (var message in channel.stream) {
      var event = jsonDecode(message);
      print('Event: $event');
      if (event['t'] == 'ev') {
        var payload = event['payload'];
        if (payload is Map) {
          var kind = payload['kind'];
          if (kind == 'text') {
            var content = payload['content'];
            if (content != null) {
              messages.add(content);
            }
          } else if (kind == 'image') {
            var imageUrl = payload['url'];
            if (imageUrl != null) {
              messages.add(imageUrl);
            }
          }
          // Add more else if blocks here for other kinds of events
        }
      }
    }

    return messages;
  }


}
