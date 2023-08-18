abstract class Line {}
class SolidLine extends Line {}
class DottedLine extends Line {
  final double gapSize;

  DottedLine({required this.gapSize});
}