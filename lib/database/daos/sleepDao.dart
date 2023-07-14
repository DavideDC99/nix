import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class SleepDao {
  //SELECT -> this allows to obtain the bedTime in a certain date
  @Query('SELECT goSleep FROM Sleep WHERE dateTime = :time')
  Future<String?> findBedTime(DateTime time);
  
  //SELECT -> this allows to obtain the wakeUpTime in a certain date
  @Query('SELECT wakeUp FROM Sleep WHERE dateTime = :time')
  Future<String?> findWakeup(DateTime time); 
  
  //SELECT -> this allows to obtain the duration of sleep in a certain date
  @Query('SELECT duration FROM Sleep WHERE dateTime = :time')
  Future<double?> findSleepDuration(DateTime time); 

  //SELECT -> this allows to obtain the efficiency of sleep in a certain date
  @Query('SELECT eff FROM Sleep WHERE dateTime = :time')
  Future<int?> findSleepEff(DateTime time); 

  //INSERT -> this allows to add a Sleep in the table
  @insert
  Future<void> insertSleep(Sleep sleep);

  //DELETE -> this allows to delete a Sleep from the table [not used]
  @delete
  Future<void> deleteSleep(Sleep sleep);

  //UPDATE -> this allows to update a Sleep entry [not used]
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);
  
  //SELECT -> this allows to obtain the first entry of the Sleep table
  @Query('SELECT * FROM Sleep ORDER BY dateTime ASC LIMIT 1')
  Future<Sleep?> findFirstDayInDb();
  
  //SELECT -> this allows to obtain the last entry of the Sleep table
  @Query('SELECT * FROM Sleep ORDER BY dateTime DESC LIMIT 1')
  Future<Sleep?> findLastDayInDb();
  
} //SleepDao