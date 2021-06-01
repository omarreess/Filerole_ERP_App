import 'package:flutter/material.dart';

var barColor = Colors.grey;

class BtmSheetBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15, top: 10),
          height: 5,
          width: size.width * 0.1,
          decoration: BoxDecoration(
            color: barColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ],
    );
  }
}
