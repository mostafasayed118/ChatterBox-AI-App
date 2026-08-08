import 'package:chat_ai_app/features/chat_gemini/model/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message', () {
    test('creates with required fields', () {
      final message = Message(text: 'Hello', isUser: true);
      expect(message.text, 'Hello');
      expect(message.isUser, true);
    });

    test('creates AI message', () {
      final message = Message(text: 'Hi there', isUser: false);
      expect(message.text, 'Hi there');
      expect(message.isUser, false);
    });

    test('handles empty text', () {
      final message = Message(text: '', isUser: true);
      expect(message.text, '');
      expect(message.isUser, true);
    });

    test('handles long text', () {
      final longText = 'A' * 1000;
      final message = Message(text: longText, isUser: false);
      expect(message.text, longText);
      expect(message.text.length, 1000);
    });
  });
}
