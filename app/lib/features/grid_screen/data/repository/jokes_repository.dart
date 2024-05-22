import 'package:injectable/injectable.dart';

import 'package:zlp_jokes/core/services/network_service.dart';
import 'package:zlp_jokes/features/grid_screen/data/models/joke_model.dart';

@injectable
class JokesRepository {
  final NetworkService networkService;
  JokesRepository(this.networkService);

  Future<List<JokeModel>> getJokes() async {
    final response = await networkService.get<List<dynamic>>('/joke');
    final jokes = (response.data as List<dynamic>).map((e) => JokeModel.fromJson(e as Map<String, dynamic>)).toList();
    return jokes;
  }

  Future<JokeModel> getJokeById(int id) async {
    final response = await networkService.get('/joke/$id');
    return JokeModel.fromJson(response.data);
  }
}
