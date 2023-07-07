import 'package:intl/intl.dart';

class Steps {
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('yyyy-MM-dd HH:MM:ss').parse('$date${json["time"]}'),
        value = int.parse(json["value"]);
}
