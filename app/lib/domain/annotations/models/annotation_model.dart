import 'package:flutter/foundation.dart';

@immutable
final class AnnotationModel {
  const AnnotationModel({
    this.id,
    required this.text,
    required this.from,
    required this.to,
  });

  final int? id;
  final String text;
  final int from;
  final int to;

  factory AnnotationModel.fromJson(Map<String, dynamic> json) => AnnotationModel(
        id: json['id'] as int?,
        text: json['text'] as String,
        from: json['from'] as int,
        to: json['to'] as int,
      );

  toJson() => {
        if (id != null) 'id': id,
        'text': text,
        'from': from,
        'to': to,
      };
}
