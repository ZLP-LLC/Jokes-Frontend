import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/services/network_service.dart';
import 'package:zlp_jokes/domain/annotations/models/annotation_model.dart';

@injectable
class AnnotationsRepostitory {
  final NetworkService networkService;

  AnnotationsRepostitory(this.networkService);

  Future<List<AnnotationModel>> getAnnotations({required int jokeId}) async {
    final response = await networkService.get<List<dynamic>>('/joke/$jokeId/annotations');
    final annotations =
        (response.data as List<dynamic>).map((e) => AnnotationModel.fromJson(e as Map<String, dynamic>)).toList();
    return annotations;
  }

  Future<void> pushAnnotation({required int jokeId, required AnnotationModel annotation}) async {
    await networkService.post(
      '/joke/$jokeId/annotations',
      data: annotation.toJson(),
    );
  }
}
