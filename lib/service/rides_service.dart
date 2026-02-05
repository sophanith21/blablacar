import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    return availableRides
        .where((e) => e.departureLocation == departure)
        .toList();
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    return availableRides
        .where((e) => e.remainingSeats >= requestedSeat)
        .toList();
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> newList = [];
    if (departure != null && seatRequested != null) {
      newList = _filterByDeparture(departure);
      newList = _filterSeatByNewList(newList, seatRequested);
    } else if (departure != null && seatRequested == null) {
      newList = _filterByDeparture(departure);
    } else {
      newList = _filterBySeatRequested(seatRequested!);
    }
    return newList;
  }

  static List<Ride> _filterSeatByNewList(
    List<Ride> newList,
    int seatRequested,
  ) {
    return newList.where((e) => e.remainingSeats >= seatRequested).toList();
  }

  static List<Ride> _filterDepartureByNewList(
    List<Ride> newList,
    Location departure,
  ) {
    return newList.where((e) => e.departureLocation == departure).toList();
  }
}
