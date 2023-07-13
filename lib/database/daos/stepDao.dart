import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepDao {
  //SELECT -> this allows to obtain the sum of steps done in a certain date
  @Query('SELECT SUM(value) FROM Steps WHERE dateTime between :startTime and :endTime')
  Future<int?> findStepsbyDate(DateTime startTime, DateTime endTime);

  //SELECT -> this allows to obtain all the entries of the Step table
  @Query('SELECT * FROM Steps')
  Future<List<Steps>> findAllSteps();

  //INSERT -> this allows to add a Steps in the table
  @insert
  Future<void> insertStep(Steps steps);

  //DELETE -> this allows to delete a Steps from the table
  @delete
  Future<void> deleteStep(Steps steps);

  //UPDATE -> this allows to update a HR entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateStep(Steps steps);
  
  //SELECT -> this allows to obtain the first entry of the Step table
  @Query('SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1')
  Future<Steps?> findFirstDayInDb();
  
  //SELECT -> this allows to obtain the last entry of the Step table
  @Query('SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1')
  Future<Steps?> findLastDayInDb();

} //StepDao