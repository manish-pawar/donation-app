import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.blue,
          size: 150.0,
        ),
      ),
    );
  }
}