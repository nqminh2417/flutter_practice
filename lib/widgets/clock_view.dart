import "dart:async";
import "dart:math";

import "package:flutter/material.dart";
import "package:moment_dart/moment_dart.dart";

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          // Your state update code here
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: ClockPainter(),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var now = Moment.now();
  // 60s --> 360 degrees // 1s --> 6 degrees
  // 12 hours --> 360 degrees, 1 hour --> 30 degrees, 1 minute --> 0.5 degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = const Color(0xff444974);

    var outlineBrush = Paint()
      ..color = const Color(0xffeaecff)
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke;

    var centerFillBrush = Paint()..color = const Color(0xffeaecff);

    var dashBrush = Paint()..color = const Color(0xffeaecff);

    var secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xff748ef6), Color(0xff77ddff)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xffea74ab), Color(0xffc279fb)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    // Draw the clock face
    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 30, outlineBrush);

    // Draw the clock hands
    var hourAngle = -pi / 2 + (now.hour * 30 + now.minute * 0.5) * pi / 180;
    var minAngle = -pi / 2 + now.minute * 6 * pi / 180;
    var secAngle = -pi / 2 + now.second * 6 * pi / 180;

    var hourHandX = centerX + 50 * cos(hourAngle);
    var hourHandY = centerX + 50 * sin(hourAngle);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 70 * cos(minAngle);
    var minHandY = centerX + 70 * sin(minAngle);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 90 * cos(secAngle);
    var secHandY = centerX + 90 * sin(secAngle);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 14, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    // Draw clock numbers
    var numberTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    var numberRadius = radius * 0.8;
    var anglePerNumber = 2 * pi / 12;
    for (var i = 1; i <= 12; i++) {
      var numberAngle =
          -pi / 2 + anglePerNumber * i; // Subtract pi/2 to start from the top

      var numberX = centerX + cos(numberAngle) * numberRadius;
      var numberY = centerY + sin(numberAngle) * numberRadius;

      var numberTextSpan = TextSpan(
        text: i.toString(),
        style: numberTextStyle,
      );

      var numberTextPainter = TextPainter(
        text: numberTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      numberTextPainter.layout();

      canvas.save(); // Save the canvas state to restore after rotation
      canvas.translate(numberX, numberY); // Translate to the number position

      numberTextPainter.paint(
          canvas,
          Offset(-numberTextPainter.width / 2,
              -numberTextPainter.height / 2)); // Paint the number
      canvas.restore(); // Restore the canvas state
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
