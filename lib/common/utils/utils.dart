import 'package:shared_preferences/shared_preferences.dart';

class CommonUtils {
  String twoDigitWholeNumber(int number) {
    return number.abs() < 10 ? '0$number' : number.toString();
  }

  String graphQLError(String errorMessage) {
    return errorMessage
        .replaceAll('GraphQL Errors:', '')
        .replaceAll(': Undefined location', '')
        .replaceAll('Network Errors:', '');
  }

  Future<void> setFirstTimeAppLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstTime', 'No');
  }

  Future<String> getFirstTimeAppLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstTime = prefs.get('firstTime');
    return firstTime;
  }

  String serviceTypeDescription(String serviceType, bool split) {
    String type = '';
    if (serviceType == 'Barber') {
      type = 'barber';
    }
    if (serviceType == 'Hairdresser') {
      type = split ? 'hair\ndresser' : 'hairdresser';
    }
    if (serviceType == 'Makeup artist') {
      type = split ? 'makeup\nartist' : 'makeup artist';
    }
    if (serviceType == 'Massage') {
      type = 'masseur';
    }
    if (serviceType == 'Nail technician') {
      type = split ? 'nail\ntechnicians' : 'nail technicians';
    }
    if (serviceType == 'Spa') {
      type = 'spa';
    }

    return type;
  }

  String serviceTypeImagePath(String serviceType) {
    String imagePath = '';
    if (serviceType == 'Barber') {
      imagePath = 'assets/images/barber.png';
    }
    if (serviceType == 'Hairdresser') {
      imagePath = 'assets/images/hairdresser.png';
    }
    if (serviceType == 'Makeup artist') {
      imagePath = 'assets/images/makeup_artist.png';
    }
    if (serviceType == 'Massage') {
      imagePath = 'assets/images/spa.png';
    }
    if (serviceType == 'Nail technician') {
      imagePath = 'assets/images/nail_technician.png';
    }
    if (serviceType == 'Spa') {
      imagePath = 'assets/images/spa.png';
    }

    return imagePath;
  }

  Map<String, dynamic> providerRating(List<dynamic> ratings) {
    double rating;
    double ratingStar;
    String ratingStatus;

    if (ratings.length <= 0) {
      return {
        'rating': '#',
        'ratingStatus': 'Not yet rated',
      };
    }

    double totalRating = ratings.fold(0, (total, rating) {
      return total += rating['rating'];
    });
    rating = totalRating / (5 * ratings.length) * 100;
    ratingStar = (totalRating / (5 * ratings.length)) * 5;

    if (rating >= 70) {
      ratingStatus = 'Superb';
    } else if (rating >= 50) {
      ratingStatus = 'Fair';
    } else {
      ratingStatus = 'Poor';
    }

    return {
      'rating': '${rating.toStringAsFixed(2)}',
      'ratingStar': ratingStar,
      'ratingStatus': ratingStatus,
    };
  }


  Future<void> setBookingMadePayloadId(
      int barberBookingMadePayloadId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'barberBookingMadePayloadId', barberBookingMadePayloadId);
  }

  Future<int> getBookingMadePayloadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int barberBookingMadePayloadId = prefs.getInt('barberBookingMadePayloadId');

    return barberBookingMadePayloadId;
  }

  Future<void> setHairdresserBookingMadePayloadId(
      int hairdresserBookingMadePayloadId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'hairdresserBookingMadePayloadId', hairdresserBookingMadePayloadId);
  }

  Future<int> getHairdresserBookingMadePayloadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hairdresserBookingMadePayloadId =
    prefs.getInt('hairdresserBookingMadePayloadId');

    return hairdresserBookingMadePayloadId;
  }

  Future<void> setMakeupArtistBookingMadePayloadId(
      int makeupArtistBookingMadePayloadId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'makeupArtistBookingMadePayloadId', makeupArtistBookingMadePayloadId);
  }

  Future<int> getMakeupArtistBookingMadePayloadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int makeupArtistBookingMadePayloadId =
    prefs.getInt('makeupArtistBookingMadePayloadId');

    return makeupArtistBookingMadePayloadId;
  }

  Future<void> setNailTechnicianBookingMadePayloadId(
      int nailTechnicianBookingMadePayloadId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('nailTechnicianBookingMadePayloadId',
        nailTechnicianBookingMadePayloadId);
  }

  Future<int> getNailTechnicianBookingMadePayloadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int nailTechnicianBookingMadePayloadId =
    prefs.getInt('nailTechnicianBookingMadePayloadId');

    return nailTechnicianBookingMadePayloadId;
  }
}
