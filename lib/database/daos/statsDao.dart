import 'package:floor/floor.dart';
import 'package:nix/database/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StatsDao {
  //SELECT -> this allows to obtain the score of a certain test done in a certain month
  @Query('SELECT score FROM Stats WHERE month = :month AND id =:id')
  Future<int?> findScore(DateTime month, int id);

  //INSERT -> this allows to add a Stats in the table
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertScore(Stats stats);

  //DELETE -> this allows to delete a Stats from the table [not used]
  @delete
  Future<void> deleteScore(Stats stats);

  //UPDATE -> this allows to update a Stats entry [not used]
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateScore(Stats stats);

} //StatsDao