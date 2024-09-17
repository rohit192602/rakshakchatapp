import 'package:flutter/services.dart';

class EncryptionService {
  static const MethodChannel _channel = MethodChannel('com.example/encryption');

  Future<String> encrypt(String plainText) async {
    final String encryptedText =
        await _channel.invokeMethod('encrypt', {'data': plainText});
    return encryptedText;
  }

  Future<String> decrypt(String encryptedText) async {
    final String decryptedText =
        await _channel.invokeMethod('decrypt', {'data': encryptedText});
    return decryptedText;
  }
}
