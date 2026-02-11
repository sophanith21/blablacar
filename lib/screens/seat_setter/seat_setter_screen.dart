import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class SeatSetterScreen extends StatefulWidget {
  const SeatSetterScreen({super.key, required this.initRequestedSeat});
  final int initRequestedSeat;

  @override
  State<SeatSetterScreen> createState() => _SeatSetterScreenState();
}

class _SeatSetterScreenState extends State<SeatSetterScreen> {
  late int currentRequestedSeat;

  @override
  void initState() {
    super.initState();
    currentRequestedSeat = widget.initRequestedSeat;
  }

  void onIncrement() {
    setState(() {
      currentRequestedSeat++;
    });
  }

  void onDecrement() {
    if (currentRequestedSeat > 1) {
      setState(() {
        currentRequestedSeat--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          BlaSpacings.l,
          0,
          BlaSpacings.l,
          BlaSpacings.l,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Number of seats to book", style: BlaTextStyles.heading),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: currentRequestedSeat > 1 ? onDecrement : null,
                  icon: Icon(Icons.remove_circle_outline, size: 30),
                ),
                Text(
                  currentRequestedSeat.toString(),
                  style: BlaTextStyles.heading,
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: Icon(Icons.add_circle_outline, size: 30),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 100,
                child: BlaButton(
                  label: "Confirm",
                  onTap: () => Navigator.pop(context, currentRequestedSeat),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
