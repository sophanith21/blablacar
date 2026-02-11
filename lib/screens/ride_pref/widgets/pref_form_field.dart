import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class PrefFormField extends StatelessWidget {
  const PrefFormField({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
    this.onTrailTap,
    this.trailingIconData,
    this.iconWeight,
  });
  final IconData iconData;
  final FontWeight? iconWeight;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onTrailTap;
  final IconData? trailingIconData;

  const PrefFormField.withTrail({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
    required this.onTrailTap,
    required this.trailingIconData,
    this.iconWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(
        iconData,
        fontWeight: iconWeight,
        color: BlaColors.iconLight,
      ),
      title: Text(
        label,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      trailing: trailingIconData != null
          ? IconButton(
              onPressed: onTrailTap,
              icon: Icon(trailingIconData),
              color: BlaColors.primary,
            )
          : null,
    );
  }
}
