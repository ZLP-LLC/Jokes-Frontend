import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/services/network_service.dart';

@injectable
class RatingRepository {
  final NetworkService networkService;

  RatingRepository(this.networkService);

  Future<void> rateJoke(int jokeId, double rating) async {
    await networkService.post(
      '/joke/$jokeId/rating',
      data: {
        'rating': rating,
      },
    );
  }
}
