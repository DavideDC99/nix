import 'package:floor/floor.dart';

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Sleep {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final DateTime dateTime;
  final String goSleep;
  final String wakeUp;
  final double duration;
  final int eff;

  //Default constructor
  Sleep(
    this.id,
    this.dateTime,
    this.goSleep,
    this.wakeUp,
    this.duration,
    this.eff
  );

}