import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key});

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Color _baseColor = const Color.fromARGB(255, 112, 110, 110);
  Color _highlightColor = const Color.fromARGB(255, 213, 207, 207);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _startColorAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _baseColor = _baseColor == const Color.fromARGB(255, 107, 105, 105)
            ? const Color.fromARGB(255, 168, 165, 165)
            : const Color.fromARGB(255, 86, 83, 83);
        _highlightColor = _highlightColor == const Color.fromARGB(255, 213, 207, 207)
            ? const Color.fromARGB(255, 240, 235, 235)
            : const Color.fromARGB(255, 213, 207, 207);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: _highlightColor,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                height: 240.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                height: 220.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



 Positioned allproductstext() {
    return Positioned(
        top: 25.h,
        left: 0,
        right: 0,
        child: Container(
            height: 55.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(40),
                topStart: Radius.circular(40),
              ),
            ),
            child: Center(
              child: CustomText(
                text: 'All products',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            )));
  }