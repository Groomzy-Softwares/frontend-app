import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtil {
  // Store signed in user token
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Get currently signed in user
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    return token;
  }

  // Store logged in user
  Future<void> setUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  // Get currently signed in user
  Future<String> getUser() async {
    try {
      // Verify the signature in the JWT and extract its claim set
      final decClaimSet = verifyJwtHS256Signature(
        await this.getToken(),
        env['JWT_SECRET'],
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (DateTime.now().isAfter(decClaimSet.expiry)) {
        await prefs.setString('user', null);
        return null;
      }

      String user = prefs.getString('user');
      return user;
    } catch (e) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', null);
      return null;
    }
  }
}
