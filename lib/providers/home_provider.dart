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
  late int? wakeuptime;
  late int? bedtime;
  late double? duration;
  late int? eff;
  late int? monthscore;
  late int wellbeingscore;
  final AppDatabase database;

  // data fetched from external services
  late List<Steps> _steps;
  late List<Sleep> _sleep;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  late DateTime lastFetch;
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.impactService, this.database) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    await getStepOfDay(showDate);
    // await getSleepOfDay(showDate);
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
  Future<void> _fetchAndCalculate() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 2));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }
    _steps = await impactService.getStepsFromDay(lastFetch);
    for (var element in _steps) {
      database.stepDao.insertStep(element);
    } // db add to the table
/*
    _sleep = await impactService.getSleepFromDay(lastFetch);
    for (var element in _sleep) {
      database.sleepDao.insertSleep(element);
    } // db add to the table
    */
/*
    wellbeingscore = _calculateWellbeing(_steps.last.value);
    _calculateExposure(_heartRates, _pm25);
    */
  }

  // method to trigger a new data fetching
  Future<void> refresh() async {
    await _fetchAndCalculate();
    await getStepOfDay(showDate);
    //await getSleepOfDay(showDate);
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

  // method to select only the data of the chosen day
  Future<void> getStepOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await database.stepDao.findFirstDayInDb();
    var lastDay = await database.stepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;

    dailysteps = await database.stepDao.findStepsbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }
  
  // method to select only the data of the chosen day
  Future<void> getSleepOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await database.sleepDao.findFirstDayInDb();
    var lastDay = await database.sleepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;
  
    wakeuptime = await database.sleepDao.findWakeup(
        DateUtils.dateOnly(showDate),);
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
    
     bedtime = await database.sleepDao.findBedTime(
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

}
