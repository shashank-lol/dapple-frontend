import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoAppointments extends StatelessWidget {
  const NoAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/icons/heartratelk.png"),
        Center(
          child:Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Text("No Upcoming Appointments"),),
          ),
      ],
    );
  }
}
