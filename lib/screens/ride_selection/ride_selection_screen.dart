import 'package:blabla/models/ride/ride.dart';
import 'package:blabla/models/ride_pref/ride_pref.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:flutter/material.dart';

class RideSelectionScreen extends StatefulWidget {
  const RideSelectionScreen({super.key, required this.ridePref});
  final RidePref ridePref;

  @override
  State<RideSelectionScreen> createState() => _RideSelectionScreenState();
}

class _RideSelectionScreenState extends State<RideSelectionScreen> {
  List<Ride> get rides => RidesService.filterBy(
    departure: widget.ridePref.departure,
    seatRequested: widget.ridePref.requestedSeats,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: BlaColors.greyLight),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Duration time = rides[index].arrivalDateTime.difference(
            rides[index].departureDate,
          );

          return RideCard(ride: rides[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: BlaSpacings.m);
        },
        itemCount: rides.length,
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  const RideCard({super.key, required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BlaColors.primary,
      child: Column(
        children: [
          Text("Departure: ${ride.departureLocation.name}"),
          Text("Arrival: ${ride.arrivalLocation.name}"),
          Text(
            "Departure Time: ${DateTimeUtils.formatTime(ride.departureDate)}",
          ),
          Text(
            "Arrival Time: ${DateTimeUtils.formatTime(ride.arrivalDateTime)}",
          ),

          Text("Available Seats: ${ride.departureLocation.name}"),
        ],
      ),
    );
  }
}
