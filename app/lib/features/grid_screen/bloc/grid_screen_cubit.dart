import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/di/di.dart';
import 'package:zlp_jokes/features/grid_screen/data/repository/jokes_repository.dart';
import 'package:zlp_jokes/utils/app_state.dart';

// const Map<String, dynamic> json1 = {
//   'id': 1,
//   'text': 'Появился корейский компьютерный вирус. Он съедает "@" из почтовых адресов"',
//   'rating': 0.9,
// };

// const Map<String, dynamic> json2 = {
//   'id': 1,
//   'text':
//       'Два друга стоят в очереди. Один рассказывает анекдот: - Что делать, если у эпилептика начался приступ в ванне? Не знаешь? Ха! Нужно бросить в воду грязное бельё и добавить стирального порошка!  Посмеялись. Тут к ним поворачивается стоящий в очереди мужчина и укоризненно говорит: - Как вам не стыдно! У меня так племянник погиб... Носком подавился...',
//   'rating': 0.9,
// };

// const Map<String, dynamic> json3 = {
//   'id': 1,
//   'text':
//       'Едут как-то мужики в поезде. Проезжают поле, а на нём коровы пасутся. Один из мужиков восклицает: —О, на этом поле 343 коровы! Никто не обращает на это внимания, едут дальше. Проезжают ещё одно поле с коровами. —А здесь 427 коров! Снова никто не обращает внимания, едут дальше. И вот, в третий раз проезжают поле с коровами. Мужик снова: А здесь 634! Все в поезде не выдерживают, идут к машинисту, останавливают поезд, выходят, идут пересчитывать всех коров. Мужик оказался прав, коров действительно было 634. Все в недоумении, подходят к мужику и спрашивают: —Но как ты смог угадать —Очень просто, считаю ноги, и делю на четыре.',
//   'rating': 0.85,
// };

// const List<Map<String, dynamic>> json = [json1, json2, json3];

class GridScreenCubit extends Cubit<AppState> {
  GridScreenCubit() : super(AppStateDefault());

  final _repository = getIt<JokesRepository>();
  Future<void> loadJokes() async {
    try {
      emit(AppStateLoading());
      final jokes = await _repository.getJokes();
      emit(AppStateSuccess(jokes));
    } catch (e) {
      emit(AppState.catchErrorHandler(e));
    }
  }
}
