import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  ImageButton({@required this.image, this.onPressed, @required this.size});

  final String image;
  final VoidCallback onPressed;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(size),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0.0),
          ),
          child: Image.asset(image),
        ),
      ),
    );
  }
}
