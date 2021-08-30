import 'dart:convert';

import 'package:http/http.dart' as http;

const ACCESS_TOKEN = "07ad03910f274a72b30346380243a424";

class LocationHelper {
  static String generateLocatonPreviewImage(double lat, double lng) {
    return //"https://maps.geoapify.com/v1/staticmap?style=klokantech-basic&width=600&height=400&center=lonlat:$lng,$lat&zoom=10&apiKey=$ACCESS_TOKEN";
        "https://maps.geoapify.com/v1/staticmap?style=klokantech-basic&width=600&height=400&center=lonlat:$lng,$lat&zoom=10&marker=lonlat:$lng,$lat;color:%23ff0000;size:medium;text:1&apiKey=$ACCESS_TOKEN";
  }

  static getPlaceAddress(double lat, double lng) async {
    final url =
        "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lng&apiKey=$ACCESS_TOKEN";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['features'][0]['properties']['formatted'];
  }
}
