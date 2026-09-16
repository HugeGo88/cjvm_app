import 'package:cjvm_app/model/message_entitiy.dart';
import 'package:cjvm_app/pages/message_detail.dart';
import 'package:cjvm_app/services/firebase_messaging_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

import '../utils/color_utils.dart' as color_utils;

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Meldungen'),
      ),
      body: ValueListenableBuilder<List<MessageEntitiy>>(
        valueListenable: FirebaseMessagingService.instance.messagesNotifier,
        builder: (context, messages, _) {
          if (messages.isEmpty) {
            return const Center(
              child: Text('Keine Meldungen vorhanden'),
            );
          }
          return ListView.separated(
            itemCount: messages.length,
            separatorBuilder: (_, __) => Container(
              height: 1,
              color: color_utils.commonThemeData.primaryColor,
            ),
            itemBuilder: (context, index) {
              final message = messages[index];
              return ListTile(
                leading: Icon(
                  message.isRead
                      ? CupertinoIcons.envelope_open
                      : CupertinoIcons.envelope_badge,
                ),
                title: Text(
                  message.title.isNotEmpty ? message.title : 'Nachricht',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight:
                            message.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${message.body}\n${DateFormat('dd.MM.yyyy HH:mm').format(message.receivedAt)}',
                ),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    platformPageRoute(
                      builder: (context) => MessageDetail(
                        message: message,
                        onOpened: FirebaseMessagingService.instance.markAsRead,
                      ),
                      context: context,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
