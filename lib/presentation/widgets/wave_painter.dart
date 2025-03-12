import 'dart:ui';
import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final double expectedSuccessPercentage;
  final int numDice;
  final double expectedSuccesses;

  // Buffer and drawing area parameters
  final double horizontalBuffer;
  final double verticalBuffer;
  final double drawingWidth;
  final double drawingHeight;

  final Color badColor = Color(0xFFFF4136); // Red
  final Color neutralColor = Color(0xFFFFDC00); // Yellow
  final Color goodColor = Color(0xFF2ECC40); // Green

  final Paint fillPainter;
  final Paint expectedLinePainter;
  late Paint wavePainter;

  double _previousSliderPosition = 0;

  WavePainter({
    required this.sliderPosition,
    required this.dragPercentage,
    required this.expectedSuccessPercentage,
    this.numDice = 1,
    this.expectedSuccesses = 0,
    required this.horizontalBuffer,
    required this.verticalBuffer,
    required this.drawingWidth,
    required this.drawingHeight,
  })  : fillPainter = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill,
        expectedLinePainter = Paint()
          ..color = Colors.black
          ..strokeWidth = 3.0 {
    wavePainter = Paint()
      ..color = _calculateWaveColor(dragPercentage, expectedSuccessPercentage)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
  }

  /// Computes the color of the wave based on the drag percentage.
  Color _calculateWaveColor(double dragPercentage, double expectedPercentage) {
    const double biasFactor = 0.4; // 70% of the transition range

    if (dragPercentage < expectedPercentage) {
      // Interpolate Red to Yellow with 70% bias
      double t = dragPercentage / (1 - expectedPercentage * biasFactor);
      t = t.clamp(0.0, 1.0); // Ensure stays in range
      return Color.lerp(badColor, neutralColor, t) ?? neutralColor;
    } else {
      // Interpolate Yellow to Green with 70% bias
      double t = (dragPercentage - expectedPercentage) /
          ((1 - expectedPercentage) * biasFactor);
      t = t.clamp(0.0, 1.0); // Ensure stays in range
      return Color.lerp(neutralColor, goodColor, t) ?? goodColor;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the drawing area - use almost all available space
    final drawingArea = Rect.fromLTWH(
        horizontalBuffer, // Left buffer
        verticalBuffer * 0.8, // Reduced top buffer
        drawingWidth, // Width between buffers
        drawingHeight - (verticalBuffer) // Extend down almost to bottom
        );

    // Paint elements in correct order for layering
    _paintWaveLine(canvas, size, drawingArea);
    _paintAnchors(canvas, size, drawingArea);
    _paintExpectedSuccessDot(canvas, size, drawingArea);
    _paintExpectedSuccessText(canvas, size, drawingArea);
    _paintDiceCountAnnotation(canvas, size, drawingArea);
  }

  void _paintExpectedSuccessDot(Canvas canvas, Size size, Rect drawingArea) {
    double xPosition =
        drawingArea.left + (expectedSuccessPercentage * drawingArea.width);

    // Only draw if within the drawing area
    if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
      // Create a dot on the wave line - slightly smaller than anchor points
      final dotPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          Offset(xPosition, drawingArea.bottom),
          4.0, // Slightly smaller than anchor points (5.0)
          dotPaint);
    }
  }

  void _paintExpectedSuccessText(Canvas canvas, Size size, Rect drawingArea) {
    final textPainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    double xPosition =
        drawingArea.left + (expectedSuccessPercentage * drawingArea.width);

    // Only draw if within the drawing area
    if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
      textPainter.text = TextSpan(
        text: expectedSuccesses.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout(maxWidth: 100);

      // Center the text below the expected dot
      double centeredXOffset = xPosition - (textPainter.width / 2);

      // Ensure text stays within bounds
      centeredXOffset = centeredXOffset.clamp(
          drawingArea.left, drawingArea.right - textPainter.width);

      // Position text below the wave line
      double textY = drawingArea.bottom + 10;
      textPainter.paint(canvas, Offset(centeredXOffset, textY));
    }
  }

  void _paintDiceCountAnnotation(Canvas canvas, Size size, Rect drawingArea) {
    final textPainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    // Annotate number of dice below the right anchor point
    textPainter.text = TextSpan(
      text: '$numDice',
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();

    // Center the text below the right anchor point
    double centeredXOffset = drawingArea.right - (textPainter.width / 2);

    // Position text below the wave line
    double textY = drawingArea.bottom + 10;
    textPainter.paint(canvas, Offset(centeredXOffset, textY));
  }

  void _paintAnchors(Canvas canvas, Size size, Rect drawingArea) {
    // Position anchors exactly at the ends of the drawing area
    double waveCenterY = drawingArea.bottom;
    canvas.drawCircle(Offset(drawingArea.left, waveCenterY), 5.0, fillPainter);
    canvas.drawCircle(Offset(drawingArea.right, waveCenterY), 5.0, fillPainter);
  }

  void _paintWaveLine(Canvas canvas, Size size, Rect drawingArea) {
    WaveCurveDefinitions waveCurve =
        _calculateWaveLineDefinitions(size, drawingArea);
    double waveY = drawingArea.bottom;

    Path path = Path();
    path.moveTo(drawingArea.left, waveY);
    path.lineTo(waveCurve.startofBezier, waveY);
    path.cubicTo(
        waveCurve.leftControlPoint1,
        waveY,
        waveCurve.leftControlPoint2,
        waveCurve.controlHeight,
        waveCurve.centerPoint,
        waveCurve.controlHeight);
    path.cubicTo(waveCurve.rightControlPoint1, waveCurve.controlHeight,
        waveCurve.rightControlPoint2, waveY, waveCurve.endOfBezier, waveY);
    path.lineTo(drawingArea.right, waveY);

    canvas.drawPath(path, wavePainter);
  }

  WaveCurveDefinitions _calculateWaveLineDefinitions(
      Size size, Rect drawingArea) {
    // Further increase the wave height by adjusting these factors
    double minWaveHeight = drawingArea.height * 0.1; // Further reduced minimum
    double maxWaveHeight =
        drawingArea.height * 0.95; // Increased maximum even more

    // Calculate the control height for the wave peak
    double controlHeight = drawingArea.top +
        (drawingArea.height - minWaveHeight) -
        (maxWaveHeight * dragPercentage);

    // Calculate bend and bezier width - standard values
    double bendWidth = 20 + 20 * dragPercentage;
    double bezierWidth = 20 + 20 * dragPercentage;

    // Ensure the slider position is correctly mapped to the drawing area
    double adjustedPosition = sliderPosition;

    // Center point cannot exceed the drawing area
    double centerPoint = adjustedPosition;
    centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);

    // Calculate bezier curve points
    double startOfBend = centerPoint - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = centerPoint + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;

    // Constrain points to the drawing area
    startOfBend = startOfBend.clamp(drawingArea.left, drawingArea.right);
    startOfBezier = startOfBezier.clamp(drawingArea.left, drawingArea.right);
    endOfBend = endOfBend.clamp(drawingArea.left, drawingArea.right);
    endOfBezier = endOfBezier.clamp(drawingArea.left, drawingArea.right);

    // Control points
    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    // Calculate bending based on position change
    double bendability = 25.0;
    double maxSlideDifference = 15.0;

    double slideDifference = (sliderPosition - _previousSliderPosition).abs();
    slideDifference = slideDifference.clamp(0.0, maxSlideDifference);

    bool moveLeft = sliderPosition < _previousSliderPosition;

    double bend =
        lerpDouble(0.0, bendability, slideDifference / maxSlideDifference) ??
            0.0;
    bend = moveLeft ? -bend : bend;

    // Apply bend to control points
    leftControlPoint1 = leftControlPoint1 + bend;
    leftControlPoint2 = leftControlPoint2 - bend;
    rightControlPoint1 = rightControlPoint1 - bend;
    rightControlPoint2 = rightControlPoint2 + bend;
    centerPoint = centerPoint - bend;

    // Constrain bent points to drawing area
    leftControlPoint1 =
        leftControlPoint1.clamp(drawingArea.left, drawingArea.right);
    leftControlPoint2 =
        leftControlPoint2.clamp(drawingArea.left, drawingArea.right);
    rightControlPoint1 =
        rightControlPoint1.clamp(drawingArea.left, drawingArea.right);
    rightControlPoint2 =
        rightControlPoint2.clamp(drawingArea.left, drawingArea.right);
    centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);

    return WaveCurveDefinitions(
      startofBezier: startOfBezier,
      endOfBezier: endOfBezier,
      leftControlPoint1: leftControlPoint1,
      leftControlPoint2: leftControlPoint2,
      rightControlPoint1: rightControlPoint1,
      rightControlPoint2: rightControlPoint2,
      controlHeight: controlHeight,
      centerPoint: centerPoint,
    );
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    _previousSliderPosition = oldDelegate.sliderPosition;
    return oldDelegate.sliderPosition != sliderPosition ||
        oldDelegate.dragPercentage != dragPercentage ||
        oldDelegate.expectedSuccessPercentage != expectedSuccessPercentage;
  }
}

class WaveCurveDefinitions {
  double startofBezier;
  double endOfBezier;
  double leftControlPoint1;
  double leftControlPoint2;
  double rightControlPoint1;
  double rightControlPoint2;
  double controlHeight;
  double centerPoint;

  WaveCurveDefinitions({
    required this.startofBezier,
    required this.endOfBezier,
    required this.leftControlPoint1,
    required this.leftControlPoint2,
    required this.rightControlPoint1,
    required this.rightControlPoint2,
    required this.controlHeight,
    required this.centerPoint,
  });
}
