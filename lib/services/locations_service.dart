import 'package:blabla/models/ride_pref/ride_pref.dart';
import 'package:blabla/services/ride_prefs_service.dart';

import '../dummy_data/dummy_data.dart';
import '../models/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static const List<Location> availableLocations =
      fakeLocations; // TODO for now fake data

  static List<Location> get locationHistories {
    List<RidePref> histories = RidePrefService.ridePrefsHistory;
    Set<Location> uniquePrevLocation = {};
    for (var prevRidePref in histories) {
      uniquePrevLocation.add(prevRidePref.departure);
      uniquePrevLocation.add(prevRidePref.arrival);
    }
    return uniquePrevLocation.toList();
  }
}
