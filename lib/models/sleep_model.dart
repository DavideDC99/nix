/*
import 'package:intl/intl.dart';

class SleepModel {
  final DateTime time;
  final DateTime start;
  final DateTime end;
  final double duration;
  final int eff;

  SleepModel({required this.time, required this.start, required this.end, required this.duration, required this.eff});

  SleepModel.fromJson(Map<String, dynamic> json)
      : time = DateFormat('MM-dd').parse('${json["data"]["date"]}'),
        start = DateFormat('HH:MM:ss').parse('${json["data"]["startTime"]}'),
        end = DateFormat('HH:MM:ss').parse('${json["data"]["endTime"]}'),
        duration = double.parse(json["data"]["duration"]/3.6e+6),
        eff = int.parse(json["data"]["efficiency"]);
}
*/