import 'package:flutter/widgets.dart';

@immutable
final class JokePart {
  const JokePart({required this.text, this.annotation});

  final String text;
  final String? annotation;
}
