import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/domain/annotations/models/annotation_model.dart';
import 'package:zlp_jokes/domain/annotations/repository/annotations_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class AnnotationPushCubit extends Cubit<AppState> {
  AnnotationPushCubit() : super(AppStateDefault());

  final _repository = getIt<AnnotationsRepository>();

  Future<bool> pushAnnotation({
    required int jokeId,
    required int textFrom,
    required int textTo,
    required String annotation,
  }) async {
    try {
      emit(AppStateLoading());
      await _repository.pushAnnotation(
        jokeId: jokeId,
        annotation: AnnotationModel(text: annotation, from: textFrom, to: textTo),
      );
      return true;
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
    return false;
  }
}
