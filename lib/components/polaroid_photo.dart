import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PolaroidPhoto extends StatelessWidget {
  final Image image;
  final String caption;
  final double rotation;

  const PolaroidPhoto({
    Key? key,
    required this.image,
    required this.caption,
    this.rotation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(rotation),
      height: 240,
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: image,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            color: Colors.white,
            child: Text(
              caption,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
