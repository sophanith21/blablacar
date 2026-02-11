import 'package:blabla/models/ride/locations.dart';
import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, this.leadingIconData});

  final Location location;
  final IconData? leadingIconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIconData != null
          ? Icon(leadingIconData, color: BlaColors.iconLight)
          : null,
      title: Text(
        location.name,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
      onTap: () => Navigator.pop(context, location),
    );
  }
}
