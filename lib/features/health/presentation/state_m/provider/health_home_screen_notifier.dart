import 'dart:async';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/common/permissions_utils.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/dialogs/show_dialog.dart';
import 'package:starter_application/features/health/data/model/request/date_params.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_steps_request_model.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_water.dart';
import 'package:starter_application/features/health/data/model/request/update_goal.dart';
import 'package:starter_application/features/health/domain/entity/health_dashboard_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_result_response_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class HealthHomeScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late int _completedCupNum;
  late double goalValue;
  late double tempGoalValue;
  int walkingSteps = 0;
  final healthCubit = HealthCubit();
  late HealthDashboardEntity healthDashboardEntity;
  int totalCupNum = 8;

  late HealthResultResponseEntity healthResultResponseEntity;

  /// Getters and Setters
  int get completedCupNum => this._completedCupNum;

  set completedCupNum(int value) => this._completedCupNum = value;
  late Timer timer;

  HealthHomeScreenNotifier() {
    authorize();
  }

  final Health health = Health();
  var types = [
    HealthDataType.STEPS,
  ];

  /// Methods

  void onPedestrianStatusError(error) {
    /// Handle the error
  }

  void onStepCountError(error) {
    /// Handle the error
  }

  Future<void> initPlatformState() async {
    /// Init streams

    /// Listen to streams and handle errors
  }

  askForPermission() async {
    PermissionStatus status = await requestStepPermission();
    print('status : $status');
    if (status.isGranted) {
      print('Permission granted');
      try {
        var result =
            await AppCheck.checkAvailability('com.google.android.apps.fitness');
        if (result != null) {
          timer = Timer.periodic(const Duration(seconds: 15), (timer) {
            getSteps();
          });
        } else {
          print('App not available');
        }
      } on PlatformException catch (e) {
        if (e.code == '400') {
          showGoogleFitNotInstalledDialog();
        }
      }
    }
  }

  List<HealthDataPoint> _healthDataList = [];
  final permissions = [HealthDataAccess.READ_WRITE];

  getSteps() async {
    DateTime now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);
    bool? requested = await health.requestAuthorization(types);
    if (requested) {
      int? steps = await health.getTotalStepsInInterval(midnight, now);
      if (steps != null) {
        walkingSteps = steps;
        updateStepsInServer();
      }
      notifyListeners();
    }
  }

  askForIosPermission() async {
    DateTime now = DateTime.now();
    initPlatformState();
  }

  Future authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    if (hasPermissions == false) {
      bool authorized =
          await health.requestAuthorization(types, permissions: permissions);
      if (authorized) {
        getSteps();
      }
    }
  }

  Future fetchData() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    _healthDataList.clear();

    try {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          startTime: yesterday, endTime: now, types: types);
      _healthDataList.addAll(healthData.take(100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }

    _healthDataList = Health().removeDuplicates(_healthDataList);
    _healthDataList.forEach((x) => print(x));
  }

  void showGoogleFitNotInstalledDialog() {
    ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.dp15),
            ),
          ),
          title: Text(
            Translation.current.google_fit_not_installed,
            style: Colors.black.bodyText1,
          ),
          content: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Text(
                        Translation.of(context).ok,
                      ),
                      onPressed: () {
                        Nav.pop();
                      },
                    ),
                    MaterialButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(35),
                        ),
                      ),
                      child: Text(
                        Translation.of(context).confirm,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (Platform.isIOS) {
                          // Handle iOS specific logic
                        } else {
                          await launch(
                              'https://play.google.com/store/apps/details?id=com.google.android.apps.fitness');
                          Nav.pop();
                        }
                      },
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  updateStepsInServer() {
    healthCubit.updateDailyStep(UpdateDailyStepsParams(
      day: DateTime.now(),
      stepsToWalk: walkingSteps,
    ));
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onAddWaterTap() {
    if (_completedCupNum != totalCupNum) {
      UpdateDailyWaterParams params = UpdateDailyWaterParams(
          date: DateFormat("yyyy-MM-dd", 'en').format(DateTime.now()),
          increase: true);
      healthCubit.updateDailyWater(params);
      _completedCupNum += 1;
      notifyListeners();
    }
  }

  void onRemoveWaterTap() {
    if (_completedCupNum != 0) {
      UpdateDailyWaterParams params = UpdateDailyWaterParams(
          date: DateFormat("yyyy-MM-dd", 'en').format(DateTime.now()),
          increase: false);
      healthCubit.updateDailyWater(params);
      _completedCupNum -= 1;
      notifyListeners();
    }
  }

  void onIncreaseGoal() {
    tempGoalValue = goalValue + 1;
    UpdateGoalParams params = UpdateGoalParams(goal: tempGoalValue);
    healthCubit.updateGoal(params);
  }

  void onDecreaseGoal() {
    tempGoalValue = goalValue - 1;
    UpdateGoalParams params = UpdateGoalParams(goal: tempGoalValue);
    healthCubit.updateGoal(params);
  }

  onGoalUpdated() async {
    await HealthProfileStaticModel.updateGoalWeight(tempGoalValue);
    goalValue = tempGoalValue;
    notifyListeners();
  }

  void getHealthResults() async {
    healthCubit.getHealthResults(NoParams());
  }

  void getHealthDashboard() async {
    DateParams dateParams =
        DateParams(date: DateFormat("yyyy-MM-dd", 'en').format(DateTime.now()));
    healthCubit.getHealthDashboard(dateParams);
  }

  onHealthDashboardLoaded(HealthDashboardEntity healthDashboardEntity) {
    this.healthDashboardEntity = healthDashboardEntity;
    _completedCupNum = healthDashboardEntity.totalCupsOfWater;
    goalValue = HealthProfileStaticModel.WEIGHT_GOAL;
    notifyListeners();
  }

  onHealthResultsLoaded(HealthResultResponseEntity healthResultResponseEntity) {
    this.healthResultResponseEntity = healthResultResponseEntity;
    getHealthDashboard();
    notifyListeners();
  }
}
