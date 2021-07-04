import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIUtils {
  // Store signed in user token
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token ?? '');
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
    await prefs.setString('user', user ?? '');
  }

  // Get currently signed in user
  Future<String> getUser() async {
    try {
      // Verify the signature in the JWT and extract its claim set
      final decClaimSet = verifyJwtHS256Signature(
        await this.getToken(),
        dotenv.env['JWT_SECRET'],
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

  Map getProviderProperties(Map provider) {
    Map address = provider['address'] ?? {};
    List bookings = provider['bookings'] ?? [];
    List dayTimes = provider['dayTimes'] ?? [];
    List serviceProviderCategories =
        provider['serviceProviderCategories'] ?? [];
    List staffs = provider['staffs'] ?? [];

    List categories = [];
    List services = [];
    List ratings = [];

    if (serviceProviderCategories.length > 0) {
      categories = serviceProviderCategories
          .map((serviceProviderCategory) {
            return serviceProviderCategory['category']['category'];
          })
          .toList()
          .toSet()
          .toList();

      services = serviceProviderCategories.map((serviceProviderCategory) {
        return serviceProviderCategory['service'];
      }).toList();
    }

    if (bookings.length > 0) {
      ratings = bookings.map((booking) => booking['rating']).toList();
    }

    List durations = services.map((service) {
      bool isHours = service['durationUnit'] == 'hrz';
      return isHours ? service['duration'] * 60 : service['duration'];
    }).toList();

    int minimumDuration = durations != null && durations.length > 0 ?
        durations.reduce((curr, next) => curr < next ? curr : next) : 0;

    return {
      'id': provider['id'],
      'name': provider['tradingName'] ?? provider['fullName'],
      'address': address,
      'bookings': bookings,
      'categories': categories,
      'services': services,
      'ratings': ratings,
      'staffs': staffs,
      'dayTimes': dayTimes,
      'minimumDuration': minimumDuration,
    };
  }
}
