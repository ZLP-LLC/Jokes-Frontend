import 'package:zlp_jokes/core/app_state.dart';
import 'package:zlp_jokes/core/auth/auth_constants.dart';
import 'package:zlp_jokes/core/auth/models/login_request.dart';
import 'package:zlp_jokes/core/auth/models/register_request.dart';
import 'package:zlp_jokes/core/services/network_service.dart';

class ServerAuthDataSource {
  final NetworkService _networkService;

  const ServerAuthDataSource({
    required NetworkService networkService,
  }) : _networkService = networkService;

  Future<String> signIn(UserLoginRequestDTO userDTO) async {
    final response = await _networkService.post(
      AuthDatasourceConstants.loginPath,
      data: userDTO.toJson(),
    );

    final result = response.data;

    if (result != null && result.containsKey(AuthDatasourceConstants.tokenKey)) {
      return result[AuthDatasourceConstants.tokenKey] as String;
    }
    throw AppStateWarning("[Sign in] Bad response: No token field!");
  }

  Future<void> signUp(UserRegistrationRequestDTO userDTO) async {
    final response = await _networkService.post(
      AuthDatasourceConstants.registrationPath,
      data: userDTO.toJson(),
    );

    final result = response.data;

    if (result == null) {
      throw AppStateWarning("[Sign up] Bad response: No data field!");
    }
  }
}
