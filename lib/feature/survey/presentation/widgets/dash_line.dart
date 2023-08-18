import 'package:flutter/material.dart';

import 'dashed_line_painter.dart';

class DashLine extends StatelessWidget {
  const DashLine({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      child: CustomPaint(
        painter: DashedLinePainter(context: context),
      ),
    );
/*    return isWholeWidth
        ? Row(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: DashedLinePainter(context: context),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomPaint(
                  painter: DashedLinePainter(context: context),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CommonText(
                text: AppLocalizations.of(context)!.orDivider,
                padding: EdgeInsets.zero,
                alignment: Alignment.topLeft,
                textAlign: TextAlign.left,
                textStyle: StyleUtils.bodyRegular(context)?.copyWith(
                  color: ColorUtils.mostSubtitleText(context).withOpacity(.3),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DashedLinePainter(context: context),
                ),
              ),
            ],
          );*/
  }
}
