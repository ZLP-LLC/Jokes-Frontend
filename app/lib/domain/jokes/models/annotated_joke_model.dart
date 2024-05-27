import 'package:zlp_jokes/domain/annotations/models/annotation_model.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_part.dart';

class AnnotatedJokeModel {
  final List<JokePart> jokeParts;
  final JokeModel jokeModel;
  String get plainText => jokeParts.map((e) => e.text).join();

  const AnnotatedJokeModel({
    required this.jokeParts,
    required this.jokeModel,
  });

  factory AnnotatedJokeModel.fromModels({
    required JokeModel jokeModel,
    required List<AnnotationModel>? annotationModels,
  }) {
    if (annotationModels != null) {
      final jokeParts = <JokePart>[];
      final annotations = annotationModels.toList()..sort((a, b) => a.from.compareTo(b.from));

      int currentIndex = 0;

      for (var annotation in annotations) {
        if (currentIndex < annotation.from) {
          jokeParts.add(
            JokePart(
              text: jokeModel.text.substring(currentIndex, annotation.from),
            ),
          );
        }

        jokeParts.add(
          JokePart(
            text: jokeModel.text.substring(annotation.from, annotation.to),
            annotation: annotation.text,
          ),
        );

        currentIndex = annotation.to;
      }

      if (currentIndex < jokeModel.text.length) {
        jokeParts.add(
          JokePart(
            text: jokeModel.text.substring(currentIndex),
          ),
        );
      }

      return AnnotatedJokeModel(
        jokeParts: jokeParts,
        jokeModel: jokeModel,
      );
    }
    return AnnotatedJokeModel(jokeModel: jokeModel, jokeParts: [JokePart(text: jokeModel.text)]);
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
