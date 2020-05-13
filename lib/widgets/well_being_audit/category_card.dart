// Individual card (representing category) in the Well Being Audit Screen.

import 'dart:math';

import 'package:flutter/material.dart';

import '../../screens/audit_screen.dart';

class CategoryCard extends StatelessWidget {
  final double cardHeight;
  final Map<String, dynamic> categoryData;

  CategoryCard({
    @required this.cardHeight,
    @required this.categoryData,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    double average(data) {
      double sum = 0;
      for (var i = 0; i < data.length; i++) sum += data[i];
      return sum / data.length;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) =>
              FadeTransition(
            opacity: animation.drive(
              Tween(begin: 0.0, end: 1.0),
            ),
            child: AuditScreen(
              categoryData: categoryData,
            ),
          ),
        ),
      ),
      child: Hero(
        tag: categoryData['imageUrl'],
        flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) =>
            DefaultTextStyle(
          style: DefaultTextStyle.of(toHeroContext).style,
          child: toHeroContext.widget,
        ),
        child: Stack(
          children: [
            Container(
              width: min(mediaQuery.size.width * 0.9, 800),
              height: cardHeight - 10,
              color: Color(0xFFC6D7C4),
              margin: const EdgeInsets.only(
                bottom: 5.0,
                top: 10.0,
                right: 10.0,
              ),
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        CustomPaint(
                          size: Size(
                            min(constraints.maxHeight, 60.0),
                            min(constraints.maxHeight, 60.0),
                          ),
                          painter: DrawTriangleShape(),
                        ),
                        Image.asset(
                          categoryData['imageUrl'],
                          height: min(37, constraints.maxHeight * 2 / 3),
                          width: min(37, constraints.maxHeight * 2 / 3),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: constraints.maxWidth - 200,
                      child: Text(
                        categoryData['category'],
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      width: min(constraints.maxHeight, 60.0),
                      height: min(constraints.maxHeight, 60.0),
                      alignment: Alignment.center,
                      child: Text(
                        average(categoryData['data']).toString(),
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: average(categoryData['data']) < 2.5
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 3.0,
              top: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: average(categoryData['data']) < 2.5
                        ? Colors.red[200]
                        : Color(0xFF8DAC9E),
                    width: 2.0,
                  ),
                ),
                child: average(categoryData['data']) < 2.5
                    ? Icon(
                        Icons.thumb_down,
                        color: Colors.red[900],
                      )
                    : Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Class to draw a triangle.
class DrawTriangleShape extends CustomPainter {
  Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Color(0xFF8DAC9D)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width / 2);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
