// import 'package:nostr/nostr.dart' as nostr;
//
// class NostrClient {
//   final nostr.Nostr nostrClient;
//
//   NostrClient(List<String> relays)
//       : nostrClient = nostr.Nostr(relays);
//
//   Future<List<Map<String, dynamic>>> fetchMessages(String accountId) async {
//     var messages = await nostrClient.getEvents(accountId);
//     return messages.map((event) => event.payload).toList();
//   }
// }