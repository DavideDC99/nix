import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class SleepDao {
  @Query('SELECT start FROM Sleep WHERE dateTime = :time')
  Future<int?> findBedTime(DateTime time); // time = datetime.now - 1

  @Query('SELECT end FROM Sleep WHERE dateTime = :time')
  Future<int?> findWakeup(DateTime time); // time = datetime.now - 1

  @Query('SELECT duration FROM Sleep WHERE dateTime = :time')
  Future<double?> findSleepDuration(DateTime time); // time = datetime.now - 1

  @Query('SELECT eff FROM Sleep WHERE dateTime = :time')
  Future<int?> findSleepEff(DateTime time); // time = datetime.now - 1

  //Query #2: INSERT -> this allows to add a HR in the table
  @insert
  Future<void> insertSleep(Sleep sleep);

  //Query #3: DELETE -> this allows to delete a HR from the table
  @delete
  Future<void> deleteSleep(Sleep sleep);

  //Query #4: UPDATE -> this allows to update a HR entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);

  @Query('SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1')
  Future<Sleep?> findFirstDayInDb();

  @Query('SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1')
  Future<Sleep?> findLastDayInDb();
  
}//HeartRatesDao