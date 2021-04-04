import 'package:pigeonholelive_sdk/src/models/live_session/chat.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/live_session.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/poll_multiple_choice.dart';
import 'package:pigeonholelive_sdk/src/models/live_session/qna.dart';

class LiveSessionFactory {
  static LiveSession make(Map<String, dynamic> data) {
    if (data.containsKey('type')) {
      if (data['type'] == 'qna') {
        return Qna.fromJson(data);
      }

      if (data['type'] == 'poll_multiple_choice') {
        return PollMultipleChoice.fromJson(data);
      }

      if (data['type'] == 'chat') {
        return Chat.fromJson(data);
      }
    }

    return LiveSession.fromJson(data);
  }
}
