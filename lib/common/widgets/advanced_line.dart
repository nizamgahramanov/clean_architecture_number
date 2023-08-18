import 'package:flutter/material.dart';

import '../../core/usecases/line.dart';
import 'line_painter.dart';
class AdvancedLine extends StatelessWidget {
  final Axis direction;
  final Line line;
  final Paint paintDef;

  const AdvancedLine({
    Key? key,
    required this.direction,
    required this.line,
    required this.paintDef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // line painter, always rendering horizontal line
    // if requested axis is vertical
    // send horizontal line with 90 degree rotated

    Paint paint = this.paintDef ?? Paint();

    Row lineWrapper = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: paint.strokeWidth,
            child: CustomPaint(
              painter: LinePainter(line: line, paintDef: paint),
            ),
          ),
        ),
      ],
    );

    if (direction == Axis.horizontal)
      return lineWrapper;
    else
      return new RotatedBox(
        quarterTurns: 1,
        child: lineWrapper,
      );
  }
}