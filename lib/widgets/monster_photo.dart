import 'package:flutter/material.dart';

class MonsterPhoto extends StatelessWidget {
  
  final String url;
  final double size;
  
  MonsterPhoto(
    this.url,
    this.size
  );
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: NetworkImage(url)
          //FileImage y AssetImage
        )
      ),
    );
  }
}