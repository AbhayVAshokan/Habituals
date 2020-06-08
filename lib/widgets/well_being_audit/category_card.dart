// Individual card (representing category) in the Well Being Audit Screen.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:habituals/resources/constants.dart';

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
          transitionDuration: const Duration(
            milliseconds: 750,
          ),
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
        child: Card(
          elevation: 5.0,
          shadowColor: Colors.blueGrey[50],
          margin: const EdgeInsets.only(
            bottom: 5.0,
            top: 10.0,
            right: 10.0,
          ),
          child: Container(
            width: min(mediaQuery.size.width * 0.9, 800),
            height: cardHeight - 10,
            color: color_card_background,
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      CustomPaint(
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxHeight * 0.75,
                        ),
                        painter: DrawTriangleShape(
                          triangleColor: categoryData['color'],
                        ),
                      ),
                      Image.asset(
                        categoryData['imageUrl'],
                        height: min(37, constraints.maxHeight),
                        width: min(37, constraints.maxHeight),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: AutoSizeText(
                      categoryData['category'],
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                    ),
                    width: min(constraints.maxHeight, 60.0),
                    height: min(constraints.maxHeight, 60.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2.0,
                        color: average(categoryData['data']) < 2.5
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) => Container(
                              height: constraints.maxHeight,
                              width: constraints.maxHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: average(categoryData['data']) < 2.5
                                      ? Colors.red[400]
                                      : Color(0x00000000),
                                  width: 1.5,
                                ),
                              ),
                              child: average(categoryData['data']) < 2.5
                                  ? FittedBox(
                                      child: Text(
                                        '!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  : FittedBox(
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Colors.green,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              average(categoryData['data']).toString(),
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Class to draw a triangle.
class DrawTriangleShape extends CustomPainter {
  final Color triangleColor;
  DrawTriangleShape({
    @required this.triangleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = Paint()
      ..color = triangleColor
      ..style = PaintingStyle.fill;

    var path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height / 2)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
