import 'package:injectable/injectable.dart';

import 'package:zlp_jokes/core/services/network_service.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';

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

  Future<void> pushJoke(String text) async {
    await networkService.post('/joke', data: {'text': text});
  }
}
