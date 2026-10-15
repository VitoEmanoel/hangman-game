import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  const HangmanDrawing({super.key, required this.errors});

  final int errors;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.22;

    return SizedBox(
      width: height * 0.9,
      height: height,
      child: CustomPaint(
        painter: _HangmanPainter(
          errors: errors,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  _HangmanPainter({required this.errors, required this.color});

  final int errors;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset point(double x, double y) => Offset(size.width * x, size.height * y);

    canvas.drawLine(point(0.1, 0.95), point(0.6, 0.95), paint);
    canvas.drawLine(point(0.25, 0.95), point(0.25, 0.05), paint);
    canvas.drawLine(point(0.25, 0.05), point(0.7, 0.05), paint);
    canvas.drawLine(point(0.7, 0.05), point(0.7, 0.18), paint);

    if (errors >= 1) {
      canvas.drawCircle(point(0.7, 0.27), size.height * 0.09, paint);
    }
    if (errors >= 2) {
      canvas.drawLine(point(0.7, 0.36), point(0.7, 0.62), paint);
    }
    if (errors >= 3) {
      canvas.drawLine(point(0.7, 0.42), point(0.58, 0.52), paint);
    }
    if (errors >= 4) {
      canvas.drawLine(point(0.7, 0.42), point(0.82, 0.52), paint);
    }
    if (errors >= 5) {
      canvas.drawLine(point(0.7, 0.62), point(0.6, 0.8), paint);
    }
    if (errors >= 6) {
      canvas.drawLine(point(0.7, 0.62), point(0.8, 0.8), paint);
    }
  }

  @override
  bool shouldRepaint(_HangmanPainter oldDelegate) {
    return oldDelegate.errors != errors || oldDelegate.color != color;
  }
}
