import 'package:blabla/models/ride/locations.dart';
import 'package:blabla/screens/location_picker/widgets/location_tile.dart';
import 'package:blabla/services/locations_service.dart';
import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({
    super.key,
    required this.currentLocationName,
    required this.locationHistory,
  });
  final String currentLocationName; // For when the user select a location again
  final List<Location> locationHistory;

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  List<Location> get locations => LocationsService.availableLocations
      .where(
        (e) =>
            e.name.toLowerCase().startsWith(textController.text.toLowerCase()),
      )
      .toList();

  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.text = widget.currentLocationName;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left),
        ),

        title: TextField(
          controller: textController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            suffixIconConstraints: BoxConstraints(),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() {
                textController.clear();
              }),
              child: Icon(Icons.clear_outlined),
            ), // myIcon is a 48px-wide widget.
            border: InputBorder.none,
            hint: Text(
              "Station Road or The Bridge Cafe",
              style: BlaTextStyles.body.copyWith(color: BlaColors.textLight),
            ),
          ),
        ),
      ),
      body: textController.text.isEmpty
          ? Column(
              children: [
                ListTile(
                  leading: Icon(Icons.my_location, color: BlaColors.iconLight),
                  title: Text(
                    "My Current Location",
                    style: BlaTextStyles.body.copyWith(
                      color: BlaColors.textNormal,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: BlaColors.iconLight,
                    size: 16,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return LocationTile(
                        location: widget.locationHistory[index],
                        leadingIconData: Icons.history,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 20);
                    },
                    itemCount: widget.locationHistory.length,
                  ),
                ),
              ],
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return LocationTile(location: locations[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemCount: locations.length,
            ),
    );
  }
}
