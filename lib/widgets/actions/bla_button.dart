import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final bool? isSecondary;
  final IconData? iconData;
  final VoidCallback onTap;

  const BlaButton({
    super.key,
    required this.label,
    this.isSecondary,
    this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return (isSecondary != null && isSecondary!)
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: BlaColors.primary,
              iconColor: BlaColors.primary,
              side: BorderSide(color: BlaColors.greyLight, width: 2),
            ),
            onPressed: onTap,
            child: Row(
              spacing: BlaSpacings.s,
              mainAxisSize: MainAxisSize.min,
              children: [if (iconData != null) Icon(iconData), Text(label)],
            ),
          )
        : FilledButton(
            style: FilledButton.styleFrom(backgroundColor: BlaColors.primary),
            onPressed: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: BlaSpacings.s,
              children: [if (iconData != null) Icon(iconData), Text(label)],
            ),
          );
  }
}
