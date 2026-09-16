import 'package:cjvm_app/model/message_entitiy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MessageEntitiy serializes and deserializes', () {
    final message = MessageEntitiy(
      id: 'id-1',
      title: 'Title',
      body: 'Body',
      receivedAt: DateTime.parse('2026-01-01T10:00:00.000Z'),
      isRead: false,
      data: const {'foo': 'bar'},
    );

    final json = message.toJson();
    final decoded = MessageEntitiy.fromJson(json);

    expect(decoded.id, message.id);
    expect(decoded.title, message.title);
    expect(decoded.body, message.body);
    expect(decoded.receivedAt.toIso8601String(), message.receivedAt.toIso8601String());
    expect(decoded.isRead, isFalse);
    expect(decoded.data['foo'], 'bar');
  });

  test('MessageEntitiy copyWith can mark messages as read', () {
    final message = MessageEntitiy(
      id: 'id-2',
      title: 'Title',
      body: 'Body',
      receivedAt: DateTime.parse('2026-01-01T10:00:00.000Z'),
    );

    final readMessage = message.copyWith(isRead: true);

    expect(readMessage.id, message.id);
    expect(readMessage.isRead, isTrue);
  });
}
