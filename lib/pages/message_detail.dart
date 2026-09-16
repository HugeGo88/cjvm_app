import 'package:cjvm_app/model/message_entitiy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

class MessageDetail extends StatefulWidget {
  final MessageEntitiy message;
  final Future<void> Function(String messageId) onOpened;

  const MessageDetail({required this.message, required this.onOpened, super.key});

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  @override
  void initState() {
    super.initState();
    widget.onOpened(widget.message.id);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.message.title.isNotEmpty ? widget.message.title : 'Nachricht'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd.MM.yyyy HH:mm').format(widget.message.receivedAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            if (widget.message.body.isNotEmpty)
              Text(
                widget.message.body,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (widget.message.body.isEmpty)
              Text(
                'Keine Nachrichtentext vorhanden.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}
