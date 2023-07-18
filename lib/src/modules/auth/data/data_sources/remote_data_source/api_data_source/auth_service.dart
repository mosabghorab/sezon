class AuthService {
  static AuthService? _instance;

  // private constructor.
  AuthService._();

  // singleton pattern.
  static AuthService get instance => _instance ?? (_instance = AuthService._());
}
