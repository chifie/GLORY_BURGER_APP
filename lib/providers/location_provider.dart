import 'package:flutter/material.dart';

/// Represents a Tanzanian location/region with its name.
class TanzanianLocation {
  final String key;
  final String nameEn;
  final String nameSw;

  const TanzanianLocation({
    required this.key,
    required this.nameEn,
    required this.nameSw,
  });

  /// Returns the localized name based on language
  String getLocalizedName(String language) =>
      language == 'sw' ? nameSw : nameEn;
}

/// Provider that manages the user's delivery location.
class LocationProvider extends ChangeNotifier {
  TanzanianLocation _selectedLocation = _locations[0]; // Default: Dar es Salaam

  TanzanianLocation get selectedLocation => _selectedLocation;

  /// Returns the list of all available locations
  static List<TanzanianLocation> get locations => _locations;

  /// Set the delivery location
  void setLocation(TanzanianLocation location) {
    _selectedLocation = location;
    notifyListeners();
  }

  /// Update the selected location by key
  void setLocationByKey(String key) {
    final location = _locations.where((l) => l.key == key).firstOrNull;
    if (location != null) {
      _selectedLocation = location;
      notifyListeners();
    }
  }

  /// All Tanzanian regions available for delivery
  static const List<TanzanianLocation> _locations = [
    TanzanianLocation(
      key: 'dar_es_salaam',
      nameEn: 'Dar es Salaam',
      nameSw: 'Dar es Salaam',
    ),
    TanzanianLocation(
      key: 'dodoma',
      nameEn: 'Dodoma',
      nameSw: 'Dodoma',
    ),
    TanzanianLocation(
      key: 'mwanza',
      nameEn: 'Mwanza',
      nameSw: 'Mwanza',
    ),
    TanzanianLocation(
      key: 'arusha',
      nameEn: 'Arusha',
      nameSw: 'Arusha',
    ),
    TanzanianLocation(
      key: 'mbeya',
      nameEn: 'Mbeya',
      nameSw: 'Mbeya',
    ),
    TanzanianLocation(
      key: 'zanzibar',
      nameEn: 'Zanzibar',
      nameSw: 'Zanzibar',
    ),
    TanzanianLocation(
      key: 'tanga',
      nameEn: 'Tanga',
      nameSw: 'Tanga',
    ),
    TanzanianLocation(
      key: 'morogoro',
      nameEn: 'Morogoro',
      nameSw: 'Morogoro',
    ),
    TanzanianLocation(
      key: 'kilimanjaro',
      nameEn: 'Kilimanjaro',
      nameSw: 'Kilimanjaro',
    ),
    TanzanianLocation(
      key: 'tabora',
      nameEn: 'Tabora',
      nameSw: 'Tabora',
    ),
    TanzanianLocation(
      key: 'iringa',
      nameEn: 'Iringa',
      nameSw: 'Iringa',
    ),
  ];
}