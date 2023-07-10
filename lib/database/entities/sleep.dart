import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Sleep {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final DateTime dateTime;
  final DateTime start;
  final DateTime end;
  final double duration;
  final int eff;

  //Default constructor
  Sleep(
    this.id,
    this.dateTime,
    this.start,
    this.end,
    this.duration,
    this.eff
  );

   Sleep.fromJson(this.id, Map<String, dynamic> json,)
      : dateTime = DateFormat('MM-dd').parse('${json["data"]["date"]}'),
        start = DateFormat('HH:MM:ss').parse('${json["data"]["startTime"]}'),
        end = DateFormat('HH:MM:ss').parse('${json["data"]["endTime"]}'),
        duration = double.parse(json["data"]["duration"]/3.6e+6),
        eff = int.parse(json["data"]["efficiency"]);
}