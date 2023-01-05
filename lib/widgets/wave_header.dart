import 'package:flutter/material.dart';

class WaveHeader extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final paint = Paint();

    paint.color = const Color.fromARGB(255, 13, 71, 161);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    final path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 1.10, size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height);
    path.lineTo( size.width, 0);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}