import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StatsDao {
  //Query #0: SELECT -> this allows to obtain the sum of steps done in a certain date
  @Query('SELECT score FROM Stats WHERE month = :month AND id =:id')
  Future<int?> findScore(int month, int id);

  //Query #2: INSERT -> this allows to add a HR in the table
  @insert
  Future<void> insertScore(Stats stats);

  //Query #3: DELETE -> this allows to delete a HR from the table
  @delete
  Future<void> deleteScore(Stats stats);

  //Query #4: UPDATE -> this allows to update a HR entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateScore(Stats stats);
}//HeartRatesDao