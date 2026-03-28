import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  List<Map<String, dynamic>> _cities = [];

  Future<void> init() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/cities.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _cities = jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      _cities = [];
    }
  }

  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> requestPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> isPermissionDeniedForever() async {
    final status = await Permission.location.status;
    return status.isPermanentlyDenied;
  }

  Future<void> openAppOSSettings() async {
    await openAppSettings();
  }

  List<Map<String, dynamic>> searchCity(String query) {
    if (query.isEmpty) return [];
    return _cities.where((city) {
      final nameEn = city['name_en']?.toString().toLowerCase() ?? '';
      final nameAr = city['name_ar']?.toString().toLowerCase() ?? '';
      final lowerQuery = query.toLowerCase();
      return nameEn.contains(lowerQuery) || nameAr.contains(lowerQuery);
    }).take(20).toList();
  }
}
