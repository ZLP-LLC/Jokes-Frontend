import 'package:injectable/injectable.dart';
import 'package:zlp_jokes/core/services/network_service.dart';
import 'package:zlp_jokes/domain/jokes/models/user_model.dart';

@injectable
class UserRepository {
  final NetworkService networkService;
  UserRepository(this.networkService);

  Future<UserModel> getUser() async {
    final result = await networkService.get('/user');
    return UserModel.fromJson(result.data);
  }
}
