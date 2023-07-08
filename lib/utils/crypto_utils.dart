import 'dart:convert';
import 'package:flostr/models/custom_rsa_private_key.dart';

CustomRSAPrivateKey parsePrivateKey(String jsonPrivateKey) {
  var privateKeyMap = jsonDecode(jsonPrivateKey);
  var modulus = BigInt.parse(base64Decode(privateKeyMap['modulus']).toString());
  var privateExponent = BigInt.parse(base64Decode(privateKeyMap['privateExponent']).toString());

  return CustomRSAPrivateKey(modulus, privateExponent);
}
