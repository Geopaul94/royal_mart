
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:royalmart/utilities/constants/constants.dart';



class SpinningLine extends StatelessWidget {
  const SpinningLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Use a percentage of the parent's constraints
            return SpinKitSpinningLines(
              color: grey,
              size:150.w,
            );
          },
        ),
      ),
    );
  }
}
