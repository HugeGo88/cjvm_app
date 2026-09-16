import 'dart:convert';
import 'dart:io';

import 'package:cjvm_app/model/message_entitiy.dart';
import 'package:cjvm_app/pages/message_detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();
  static final FirebaseMessagingService instance = FirebaseMessagingService._();

  final ValueNotifier<List<MessageEntitiy>> messagesNotifier =
      ValueNotifier<List<MessageEntitiy>>(<MessageEntitiy>[]);
  GlobalKey<NavigatorState>? _navigatorKey;
  bool _initialized = false;

  Future<void> initialize(
      {required GlobalKey<NavigatorState> navigatorKey}) async {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _navigatorKey = navigatorKey;
    await _loadMessages();
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        await saveRemoteMessage(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        final storedMessage = await saveRemoteMessage(message);
        _openDetail(storedMessage);
      },
    );

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final storedMessage = await saveRemoteMessage(initialMessage);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openDetail(storedMessage);
      });
    }
  }

  Future<void> _loadMessages() async {
    final file = await _messagesFile();
    if (!await file.exists()) {
      return;
    }
    final content = await file.readAsString();
    if (content.isEmpty) {
      return;
    }
    final List<dynamic> jsonList = jsonDecode(content);
    messagesNotifier.value = jsonList
        .map((item) => MessageEntitiy.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> _saveMessages() async {
    final file = await _messagesFile();
    final encoded = jsonEncode(messagesNotifier.value.map((e) => e.toJson()).toList());
    await file.writeAsString(encoded);
  }

  Future<File> _messagesFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/messages.json');
  }

  Future<MessageEntitiy> saveRemoteMessage(RemoteMessage remoteMessage) async {
    final title = remoteMessage.notification?.title ??
        remoteMessage.data['title']?.toString() ??
        '';
    final body = remoteMessage.notification?.body ??
        remoteMessage.data['body']?.toString() ??
        '';
    final receivedAt = remoteMessage.sentTime ?? DateTime.now();
    final id = remoteMessage.messageId ??
        '${receivedAt.millisecondsSinceEpoch}-${title.hashCode}-${body.hashCode}';

    final newMessage = MessageEntitiy(
      id: id,
      title: title,
      body: body,
      receivedAt: receivedAt,
      data: remoteMessage.data,
    );

    final currentMessages = List<MessageEntitiy>.from(messagesNotifier.value);
    final index = currentMessages.indexWhere((message) => message.id == id);

    if (index >= 0) {
      final existing = currentMessages[index];
      currentMessages[index] = newMessage.copyWith(isRead: existing.isRead);
    } else {
      currentMessages.insert(0, newMessage);
    }

    messagesNotifier.value = currentMessages;
    await _saveMessages();
    return index >= 0 ? currentMessages[index] : newMessage;
  }

  Future<void> markAsRead(String id) async {
    final currentMessages = List<MessageEntitiy>.from(messagesNotifier.value);
    final index = currentMessages.indexWhere((message) => message.id == id);
    if (index < 0 || currentMessages[index].isRead) {
      return;
    }
    currentMessages[index] = currentMessages[index].copyWith(isRead: true);
    messagesNotifier.value = currentMessages;
    await _saveMessages();
  }

  void _openDetail(MessageEntitiy message) {
    final navigatorState = _navigatorKey?.currentState;
    if (navigatorState == null) {
      return;
    }
    navigatorState.push(
      MaterialPageRoute(
        builder: (_) => MessageDetail(
          message: message,
          onOpened: markAsRead,
        ),
      ),
    );
  }
}
