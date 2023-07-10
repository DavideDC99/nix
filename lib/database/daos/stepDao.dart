import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepDao {
  //Query #0: SELECT -> this allows to obtain the sum of steps done in a certain date
  @Query('SELECT SUM(value) FROM Steps WHERE dateTime between :startTime and :endTime')
  Future<int?> findStepsbyDate(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Step table
  @Query('SELECT * FROM Steps')
  Future<List<Steps>> findAllSteps();

  //Query #2: INSERT -> this allows to add a HR in the table
  @insert
  Future<void> insertStep(Steps steps);

  //Query #3: DELETE -> this allows to delete a HR from the table
  @delete
  Future<void> deleteStep(Steps steps);

  //Query #4: UPDATE -> this allows to update a HR entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateStep(Steps steps);

  @Query('SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1')
  Future<Steps?> findFirstDayInDb();

  @Query('SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1')
  Future<Steps?> findLastDayInDb();
}//HeartRatesDao