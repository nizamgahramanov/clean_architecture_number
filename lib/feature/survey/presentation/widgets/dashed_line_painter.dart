import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final BuildContext context;
  DashedLinePainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 7, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 80), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}