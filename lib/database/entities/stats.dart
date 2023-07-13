import 'package:floor/floor.dart';

//Here, we are saying to floor that this is a class that defines an entity
@Entity(primaryKeys: ['month','id'])
class Stats {
  //month and id will be the primary key of the table. 
  
  final DateTime month;
  final int id;
  final int score;

  //Default constructor
  Stats(
    this.month,
    this.id,
    this.score,
  );
}