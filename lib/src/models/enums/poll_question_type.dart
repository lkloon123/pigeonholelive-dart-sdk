import 'package:json_annotation/json_annotation.dart';

enum PollQuestionType {
  @JsonValue('text')
  text,

  @JsonValue('numeric_scale')
  numericScale,

  @JsonValue('draggable_scale')
  draggableScale,

  @JsonValue('rating')
  rating,
}
