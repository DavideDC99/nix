import 'package:intl/intl.dart';

class Sleep {
  final DateTime start;
  final DateTime end;
  final double duration;
  final int eff;

  Sleep({required this.start, required this.end, required this.duration, required this.eff});

  Sleep.fromJson(Map<String, dynamic> json)
      : start = DateFormat('MM-dd HH:MM:ss').parse('${json["data"]["startTime"]}'),
        end = DateFormat('MM-dd HH:MM:ss').parse('${json["data"]["endTime"]}'),
        duration = double.parse(json["data"]["duration"]/3.6e+6),
        eff = int.parse(json["data"]["efficiency"]);
}