import 'package:flutter/foundation.dart';

class Memo {
  final String id;
  final String title;
  final DateTime date;
  final String data;

  Memo({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.data,
  });
}
