import 'package:blabla/screens/location_picker/location_picker_screen.dart';
import 'package:blabla/screens/ride_pref/widgets/pref_form_field.dart';
import 'package:blabla/services/locations_service.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import '../../../models/ride/locations.dart';
import '../../../models/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref?.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  @override
  void didUpdateWidget(covariant RidePrefForm oldWidget) {
    if (widget.initRidePref != oldWidget.initRidePref) {
      setState(() {
        departure = widget.initRidePref?.departure;
        departureDate = widget.initRidePref!.departureDate;
        arrival = widget.initRidePref!.arrival;
        requestedSeats = widget.initRidePref!.requestedSeats;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onLocationSwap() {
    setState(() {
      var tempLocation = departure;
      departure = arrival;
      arrival = tempLocation;
    });
  }

  Future<void> onDepartureTap() async {
    Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationPickerScreen(
            currentLocationName: departure?.name ?? "",
            locationHistory: LocationsService.locationHistories,
          );
        },
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  Future<void> onArrivalTap() async {
    Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationPickerScreen(
            currentLocationName: arrival?.name ?? "",
            locationHistory: LocationsService.locationHistories,
          );
        },
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";

  VoidCallback? getSearchFunction() {
    if (departure != null &&
        arrival != null &&
        departure != arrival &&
        departureDate.day.compareTo(DateTime.now().day) >= 0 &&
        requestedSeats > 0) {
      return () {};
    } else {
      return null;
    }
  }

  VoidCallback? getSwapFunction() {
    if (departure != null && arrival != null) {
      return onLocationSwap;
    } else {
      return null;
    }
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(BlaSpacings.radius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrefFormField.withTrail(
                  iconWeight: FontWeight.bold,
                  iconData: Icons.circle_outlined,
                  label: departureLabel,
                  onTap: onDepartureTap,
                  trailingIconData: Icons.swap_vert_outlined,
                  onTrailTap: getSwapFunction(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(height: 5),
                ),
                PrefFormField(
                  iconWeight: FontWeight.bold,
                  iconData: Icons.circle_outlined,
                  label: arrivalLabel,
                  onTap: onArrivalTap,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(height: 5),
                ),
                PrefFormField(
                  iconData: Icons.date_range_outlined,
                  label: DateTimeUtils.formatDateTime(departureDate),
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(height: 5),
                ),
                PrefFormField(
                  iconData: Icons.person_outline,
                  label: requestedSeats.toString(),
                  onTap: () {},
                ),
              ],
            ),
          ),

          SizedBox(
            height: 50,
            child: BlaButton(
              label: "Search",
              onTap: getSearchFunction(),
              borderRadius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
