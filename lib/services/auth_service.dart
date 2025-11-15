import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {
  // Register a new user
  static Future<ParseResponse> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    final user = ParseUser(username, password, email);
    return await user.signUp();
  }

  // Login user
  static Future<ParseResponse> loginUser({
    required String identifier,
    required String password,
  }) async {
    // Try to login assuming identifier is the username first
    var user = ParseUser(identifier, password, null);
    var response = await user.login();

    if (response.success) return response;

    // If login failed, try to treat identifier as email: query for user by email
    try {
      final query = QueryBuilder<ParseUser>(ParseUser.forQuery())
        ..whereEqualTo('email', identifier);

      final queryResponse = await query.query();
      if (queryResponse.success && queryResponse.results != null && queryResponse.results!.isNotEmpty) {
        final found = queryResponse.results!.first as ParseUser;
        final username = found.get<String>('username');
        if (username != null && username.isNotEmpty) {
          user = ParseUser(username, password, null);
          response = await user.login();
        }
      }
    } catch (e) {
      // ignore and return original response
    }

    return response;
  }

  // Logout user
  static Future<ParseResponse> logoutUser() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      return await user.logout();
    }
    final resp = ParseResponse();
    resp.success = false;
    resp.statusCode = 400;
    resp.error = ParseError(message: 'No user is currently logged in', code: 400);
    return resp;
  }

  // Get current user
  static Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  // Verify email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Verify password strength
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
