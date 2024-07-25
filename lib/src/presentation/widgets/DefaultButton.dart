import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {

  Function() onPressed;
  String text;
  Color color;
  Color textColor;
  EdgeInsetsGeometry margin;
  double? width;
  double height;
  IconData? iconData;
  Color iconColor;

  DefaultButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.margin = const EdgeInsets.only(bottom: 20, left: 40, right: 40),
    this.height = 45,
    this.width,
    this.iconData,
    this.iconColor = Colors.blueAccent
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: width == null ? MediaQuery.of(context).size.width : width,
      // alignment: Alignment.center,
      margin: margin,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null 
            ? Icon(
              iconData, 
              color: iconColor,
              size: 30,
            ) 
            : Container(),
            SizedBox(width: iconData != null ? 7 : 0),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
      ),
    );
  }
}