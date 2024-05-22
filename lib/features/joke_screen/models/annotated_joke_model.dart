class JokePart {
  JokePart({required this.text, this.annotation});

  final String text;
  final String? annotation;

  factory JokePart.fromString(String input) {
    final RegExp exp = RegExp(r'\((.*?)\)');

    String text = input;
    String? annotation;

    exp.allMatches(input).forEach((match) {
      text = input.substring(0, match.start).trim();
      annotation = match.group(1);
    });

    return JokePart(text: text, annotation: annotation);
  }

  factory JokePart.fromJson(String input, Map<String, dynamic> json) {
    final RegExp exp = RegExp(r'\((.*?)\)');

    String text = input;
    String? annotation;

    exp.allMatches(input).forEach((match) {
      text = input.substring(0, match.start).trim();
      annotation = json[match.group(1)];
    });

    return JokePart(text: text, annotation: annotation);
  }
}

class AnnotatedJokeModel {
  final List<JokePart> jokeParts;
  final int id;
  String get plainText => jokeParts.map((e) => e.text).join();

  AnnotatedJokeModel({required this.jokeParts, required this.id});

  // factory JokeModel.fromString(String input) {
  //   final List<JokePart> parts = [];
  //   final RegExp exp = RegExp(r'\[(.*?)\]');
  //   int lastIndex = 0;
  //   exp.allMatches(input).forEach((match) {
  //     parts.add(JokePart(text: input.substring(lastIndex, match.start)));
  //     parts.add(JokePart.fromString(match.group(1)!));
  //     lastIndex = match.end;
  //   });

  //   if (lastIndex < input.length) {
  //     parts.add(JokePart(text: input.substring(lastIndex)));
  //   }
  //   return JokeModel(jokeParts: parts, id: json['id']);
  // }

  factory AnnotatedJokeModel.fromJson(Map<String, dynamic> json) {
    final String input = json['text'];
    final List<JokePart> parts = [];
    final RegExp exp = RegExp(r'\[(.*?)\]');
    int lastIndex = 0;
    exp.allMatches(input).forEach((match) {
      parts.add(JokePart(text: input.substring(lastIndex, match.start)));
      parts.add(JokePart.fromJson(match.group(1)!, json['annottations']));
      lastIndex = match.end;
    });

    if (lastIndex < input.length) {
      parts.add(JokePart(text: input.substring(lastIndex)));
    }
    return AnnotatedJokeModel(jokeParts: parts, id: json['id']);
  }

  @override
  String toString() {
    String result = '';
    for (var element in jokeParts) {
      result += 'part: ${element.text}\n';
      result += 'annotation: ${element.annotation ?? 'null'}\n';
    }
    return result;
  }
}
