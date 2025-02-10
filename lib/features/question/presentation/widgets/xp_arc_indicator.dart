import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/custom_text_rubik.dart';

class XpArcIndicator extends StatelessWidget {
  const XpArcIndicator({super.key, required this.progress});
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextRubik(
                  text: 'XP GAINED',
                  weight: FontWeight.w400,
                  size: 12,
                  color: AppPalette.blackColor),
              CustomTextRubik(
                  text: "$progress",
                  weight: FontWeight.w800,
                  size: 24,
                  color: AppPalette.blackColor),
            ],
          ),
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
              radiusFactor: 0.80,
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              axisLineStyle: AxisLineStyle(
                thickness: 2,
                cornerStyle: CornerStyle.bothCurve,
                color: Color(0x55CCCCCC),
              ),
            ),
            RadialAxis(
              radiusFactor: 0.90,
              minimum: 2,
              maximum: 98,
              showLabels: false,
              showTicks: false,
              pointers: <GaugePointer>[
                RangePointer(
                  color: AppPalette.primaryColor,
                  value: 85,
                  cornerStyle: CornerStyle.bothCurve,
                  width: 8,
                ),
              ],
              axisLineStyle: AxisLineStyle(
                thickness: 2,
                cornerStyle: CornerStyle.bothCurve,
                color: AppPalette.grey,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
