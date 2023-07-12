import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nix/database/database.dart';
import 'package:nix/database/entities/entities.dart';
import 'package:nix/services/impact.dart';


// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late int? dailysteps;
  late String? startSleep;
  late String? endSleep;
  late double? duration;
  late int? eff;
  late int? scorePSQI;
  late int? scoreESS;
  late int? scorePHQ;
  late int wellbeingscore;
  final AppDatabase database;

  // data fetched from external services
  late List<Steps> _steps;
  late Sleep _sleep;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  late DateTime? lastFetch;
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.impactService, this.database) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    await downloadSteps(showDate);
    await downloadSleep(showDate);
    await getScoreTest(showDate);
    await getWellBeingScore();
    doneInit = true;
    notifyListeners();
  }

  Future<DateTime?> _getLastFetch() async {
    var data = await database.stepDao.findAllSteps();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
  }

  // method to fetch all data
  Future<void> _fetchAndCalculate() async { //togliere il "calculate"
    lastFetch = await _getLastFetch();
    
    if (lastFetch == null) {

      _steps = await impactService.getStepsFromDay(showDate);
      for (var element in _steps) {
        database.stepDao.insertStep(element);
      }

      _sleep = await impactService.getSleepFromDay(showDate);
        database.sleepDao.insertSleep(_sleep);

    } else {
      return;
    }
  }
  
  /*
  // method that implements the state of the art formula
  void _calculateExposure(List<HR> hr, List<PM25> pm25) {
    var vent = getMinuteVentilation(hr, 0);
    _exposure = getInhalation(vent, pm25);
    for (var element in _exposure) {
      db.exposuresDao.insertExposure(element);
    } // db add to the table
  }*/

  Future<void> downloadSteps(DateTime showDate) async { 
    
    var firstDay = await database.stepDao.findFirstDayInDb();
    var lastDay = await database.stepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime)) return;

    if (showDate.isBefore(firstDay!.dateTime)) {
      _steps = await impactService.getStepsFromDay(showDate);
      for (var element in _steps) {
      database.stepDao.insertStep(element);
      }
    }

    this.showDate = showDate;

    dailysteps = await database.stepDao.findStepsbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }
    

  Future<void> downloadSleep(DateTime showDate) async {

    DateTime truncatedShowDate = DateTime(showDate.year, showDate.month, showDate.day);

    var firstDay = await database.sleepDao.findFirstDayInDb();
    var lastDay = await database.sleepDao.findLastDayInDb();
    if (truncatedShowDate.isAfter(lastDay!.dateTime)) return;

    if (truncatedShowDate.isBefore(firstDay!.dateTime)) {
      _sleep = await impactService.getSleepFromDay(showDate);
        database.sleepDao.insertSleep(_sleep);
    }

    this.showDate = showDate;
  
    endSleep = await database.sleepDao.findWakeup(
        DateUtils.dateOnly(showDate),);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
    
    startSleep = await database.sleepDao.findBedTime(
        DateUtils.dateOnly(showDate),);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();

    duration = await database.sleepDao.findSleepDuration(
        DateUtils.dateOnly(showDate),);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();

    eff = await database.sleepDao.findSleepEff(
        DateUtils.dateOnly(showDate),);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();

  }
  
  Future<void> getScoreTest(DateTime showDate) async {

    if (showDate.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      return;
    }
    
    this.showDate = showDate;

    scorePSQI = await database.statsDao.findScore(DateTime(showDate.year, showDate.month), 1);
    notifyListeners();

    scoreESS = await database.statsDao.findScore(DateTime(showDate.year, showDate.month), 2);
    notifyListeners();

    scorePHQ = await database.statsDao.findScore(DateTime(showDate.year, showDate.month), 3);
    notifyListeners();

  }

  void insertScoreTest(Stats stats) {
    
    //this.showDate = showDate;

    database.statsDao.insertScore(stats);
    notifyListeners();

  }

  Future<void> getWellBeingScore() async {

    double pointStep;
    double pointDur;
    double pointEff;
    double pointPSQI;
    double pointESS;
    double pointPHQ;

    if (dailysteps! >= 10000) {
      pointStep = 30;
    } else {
      pointStep = ((dailysteps! * 30) / 10000);
    }

    if (duration! >= 8) {
      pointDur = 20;
    } else {
      pointDur = ((duration! * 20) / 8);
    }

    pointEff = ((eff! * 20)/100);

    if (scorePSQI == null) {
      pointPSQI = 3;
    } else {
      pointPSQI = 10 - ((scorePSQI! * 10) / 21);
    }

    if (scoreESS == null) {
      pointESS = 3;
    } else {
      pointESS = 10 - ((scoreESS! * 10) / 24);
    }

    if (scorePHQ == null) {
      pointPHQ = 3;
    } else {
      pointPHQ = 10 - ((scorePHQ! * 10) / 27);
    }
    
    wellbeingscore = (pointStep + pointDur + pointEff + pointPSQI + pointESS + pointPHQ).round();
    notifyListeners();

  }

}
