import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flostr/models/nostr_client.dart';
import 'package:flostr/screens/feed_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String accountId = '';
  String secretKey = '';

  void authenticate() {
    var nostrClient = NostrClient(['wss://atlas.nostr.land']);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedScreen(accountId, nostrClient)),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  accountId = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Account ID',
              ),
            ),
            // TextField(
            //   onChanged: (value) {
            //     setState(() {
            //       secretKey = value;
            //     });
            //   },
            //   decoration: InputDecoration(
            //     labelText: 'Secret Key',
            //   ),
            //   obscureText: true,
            // ),
            ElevatedButton(
              onPressed: authenticate,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
