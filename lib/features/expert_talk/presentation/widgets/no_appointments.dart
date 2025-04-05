import 'package:flutter/cupertino.dart';

class NoAppointments extends StatelessWidget {
  const NoAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/icons/heartratelk.png"),
        Center(
          child:Text("No Upcoming Appointments"),
          ),
      ],
    );
  }
}
