import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final int title;
  final String subtitle;
  final bool isSelected;
  final Function rebuildScreen;

  CustomCheckBox({
    @required this.title,
    @required this.isSelected,
    @required this.rebuildScreen,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: rebuildScreen,
      child: SizedBox(
        height: 80.0,
        width: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 14.0,
              child: FittedBox(
                child: Text(
                  title.toString(),
                  style: const TextStyle(fontSize: 13.0),
                ),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xAA8DAC9E),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.lightGreen[800] : Colors.white,
                ),
              ),
            ),
            subtitle != null
                ? Container(
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
