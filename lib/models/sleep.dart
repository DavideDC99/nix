import 'package:intl/intl.dart';

class Sleep {
  final DateTime start;
  final DateTime end;
  final int eff;

  Sleep({required this.start, required this.end, required this.eff});

  Sleep.fromJson(Map<String, dynamic> json)
      : start = DateFormat('MM-dd HH:MM:ss').parse('${json["data"]["startTime"]}'),
        end = DateFormat('MM-dd HH:MM:ss').parse('${json["data"]["endTime"]}'),
        eff = int.parse(json["data"]["efficiency"]);
}