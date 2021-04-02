import 'package:json_annotation/json_annotation.dart';

enum LiveSessionType {
  @JsonValue('qna')
  qna,

  @JsonValue('poll_multiple_choice')
  pollMultipleChoice,

  @JsonValue('poll_quiz')
  pollQuiz,

  @JsonValue('poll_assessment')
  pollAssessment,

  @JsonValue('poll_word_cloud')
  pollWordCloud,

  @JsonValue('poll_open_ended')
  pollOpenEnded,

  @JsonValue('survey')
  survey,

  @JsonValue('break')
  breakType, // break is special keyword

  @JsonValue('regular')
  regular,

  @JsonValue('chat')
  chat,
}
