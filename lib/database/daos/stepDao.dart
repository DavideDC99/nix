import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepDao {
  //SELECT -> this allows to obtain the number steps done in a certain date
  @Query('SELECT value FROM Steps WHERE dateTime = :time')
  Future<int?> findStepsbyDate(DateTime time);

  //SELECT -> this allows to obtain all the entries of the Step table
  @Query('SELECT * FROM Steps')
  Future<List<Steps>> findAllSteps();

  //INSERT -> this allows to add a Steps in the table
  @insert
  Future<void> insertStep(Steps steps);

  //DELETE -> this allows to delete a Steps from the table [not used]
  @delete
  Future<void> deleteStep(Steps steps);

  //UPDATE -> this allows to update a Steps entry [not used]
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateStep(Steps steps);
  
  //SELECT -> this allows to obtain the first entry of the Step table
  @Query('SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1')
  Future<Steps?> findFirstDayInDb();
  
  //SELECT -> this allows to obtain the last entry of the Step table
  @Query('SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1')
  Future<Steps?> findLastDayInDb();

} //StepDao