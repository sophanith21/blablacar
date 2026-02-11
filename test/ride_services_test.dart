import 'package:blabla/models/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';

void main() {
  print(
    RidesService.filterBy(
      departure: Location(name: "Dijon", country: Country.france),
      seatRequested: 2,
    ).toList(),
  );
}
