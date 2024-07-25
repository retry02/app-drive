import 'package:flutter/material.dart';

class DefaultImageUrl extends StatelessWidget {

  String? url;
  double width; 

  DefaultImageUrl({
    this.url,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        // margin: EdgeInsets.only(top: 25, bottom: 15),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child:  url != null 
              ? FadeInImage.assetNetwork(
                placeholder: 'assets/img/user_image.png', 
                image: url!,
                fit: BoxFit.cover,
                fadeInDuration: Duration(seconds: 1),
              )
              : Image.asset(
                'assets/img/user_image.png',
              )
          ),
        ),
    );
  }
}