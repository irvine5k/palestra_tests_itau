enum Response {
  success,
  failure,
}

abstract class Repository {
  Future<Response> login();
}

class Login {
  Login(this.repository);

  final Repository repository;

  Future<bool> authenticate() async {
    final response = await repository.login();

    if (response == Response.success) {
      return true;
    } else {
      return false;
    }
  }
}
