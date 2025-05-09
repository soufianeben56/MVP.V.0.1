import 'dart:math';

import 'package:infinity_circuit/exports.dart';
import 'package:oktoast/oktoast.dart';

import '../../utils/log_utils.dart';

class LocalBaseModel with ChangeNotifier {
  /// call this function as the initial method of view model.
  @protected
  @mustCallSuper
  void onInit() {}

  /// it will dispose the attached view model from view & the associated disposable elements too.

  @protected
  @mustCallSuper
  void onDispose() {
    dispose();
  }

  /// >>>>>>>>>>>>>>>>>>>>> Navigation >>>>>>>>>>>>>>>>>>>>>
  final NavigationService navigationService = NavigationService();

  void navigateTo(String routeName, {dynamic arguments}) {
    navigationService.next(routeName, arguments: arguments);
  }

  void redirectWithClearBackStack(String routeName, {dynamic arguments}) {
    navigationService.backAllAndNext(routeName, arguments: arguments);
  }

  Future<dynamic> redirectToPageWithAwait(String routeName,
      {dynamic arguments}) async {
    return await navigationService.next(routeName, arguments: arguments);
  }

  redirectWithPop(String routeName, {dynamic arguments}) {
    navigationService.backAndNext(routeName, arguments: arguments);
  }

  back({dynamic value}) {
    navigationService.back(value);
  }

  popUtil(String route) {
    navigationService.popUntil(route);
  }

  /// <<<<<<<<<<<<<<<<<<<<<<< Navigation <<<<<<<<<<<<<<<<<<<<<<<
  LocalisationNotifier localisationService = Provider.of<LocalisationNotifier>(
      NavigationService.navigationKey.currentContext!,
      listen: false);

  /// >>>>>>>>>>>>>>>>>>>>> Handle ViewState >>>>>>>>>>>>>>>>>>>>>
  CentralViewState _viewState = CentralViewState.idle;

  CentralViewState get viewState => _viewState;

  void updateView({CentralViewState state = CentralViewState.idle}) {
    if (_viewState != state) _viewState = state;
    if (hasListeners) {
      notifyListeners();
    }
  }

  /// <<<<<<<<<<<<<<<<<<<<<<< Handle ViewState <<<<<<<<<<<<<<<<<<<<<<<

  /// >>>>>>>>>>>>>>>>>>>>> Toast >>>>>>>>>>>>>>>>>>>>>
  /// The function showToast displays a toast message with a default state of info.
  ///
  /// Args:
  ///   state [ToastStats] : The state parameter is an optional parameter of type
  /// ToastStats. It has a default value of [ToastStats.info]. Defaults to ToastStats
  void showSnackBar({
    ToastStats state = ToastStats.error,
    Duration? duration,
    required String message,
  }) {
    showToast(
      message,
      duration: duration ?? const Duration(milliseconds: 2000),
      position: ToastPosition.top,
      backgroundColor: state.toastColor(),
      radius: 15,
      margin: EdgeInsets.zero,
      textPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.relativeWidth(5),
        vertical: SizeConfig.relativeHeight(1),
      ),
      constraints: BoxConstraints(maxWidth: SizeConfig.relativeWidth(90)),
      textStyle: TextStyle(
        fontSize: SizeConfig.setSp(12),
        color: AppColors.white,
      ),
    );
  }

  /// <<<<<<<<<<<<<<<<<<<<<<< Toast <<<<<<<<<<<<<<<<<<<<<<<

  void showConfirmationDialog({
    required String title,
    required String message,
    required Function() onTapPositive,
    required Function() onTapNegative,
    required String positiveText,
    String? negativeText,
  }) {
    showDialog(
      context: NavigationService.navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return ConfirmationDialogWidget(
          title: title,
          message: message,
          onTapPositive: onTapPositive,
          onTapNegative: onTapNegative,
          positiveText: positiveText,
          negativeText: negativeText,
        );
      },
    );
  }

  void logX({
    required String message,
    required String tag,
    StackTrace? stackTrace,
    int level = LogUtils.all,
  }) {
    /*FlutterBugfender.sendLog(
      text: message,
      tag: tag,
    );*/
    LogUtils.writeLog(
        message: message, tag: tag, level: level, stackTrace: stackTrace);
  }

  /// Navigation for notifications
  /*void onTapNotification() {
    navigateTo(RoutePaths.notificationsViewRoute);
  }*/

  /// Log Out on tapping positive
  void logout() async {
    /*if (UserPreference.getString(PrefKeys.loginStatusType) ==
        "EMPLOYEE_CHECK_IN") {
      await UserPreference.putString(PrefKeys.loginStatusType, "CHECK_IN");
      redirectWithClearBackStack(RoutePaths.signInViewRoute);
      Provider.of<DashboardTabProvider>(
              NavigationService.navigationKey.currentContext!,
              listen: false)
          .reset();
    } else if (UserPreference.getString(PrefKeys.loginStatusType) ==
        "EMPLOYEE_CHECK_OUT") {
      await UserPreference.putString(PrefKeys.loginStatusType, "LOGOUT_OUT");
      redirectWithClearBackStack(RoutePaths.signInViewRoute);
      Provider.of<DashboardTabProvider>(
              NavigationService.navigationKey.currentContext!,
              listen: false)
          .reset();
    } else if (UserPreference.getString(PrefKeys.loginStatusType) == "HR") {
      await UserPreference.putString(PrefKeys.loginStatusType, "LOGOUT_HR");
      redirectWithClearBackStack(RoutePaths.signInViewRoute);
      Provider.of<DashboardTabProvider>(
              NavigationService.navigationKey.currentContext!,
              listen: false)
          .reset();
    } else {
      redirectWithClearBackStack(RoutePaths.signInViewRoute);
      Provider.of<DashboardTabProvider>(
              NavigationService.navigationKey.currentContext!,
              listen: false)
          .reset();
    }
    await UserPreference.putBool(PrefKeys.isLogin, false);
    await UserPreference.putString(PrefKeys.lastEvent, "{}");
    await UserPreference.putString(PrefKeys.pendingCounts, "{}");
    await UserPreference.putString(PrefKeys.authToken, "");

    Provider.of<CheckInOut>(NavigationService.navigationKey.currentContext!,
            listen: false)
        .reset();
    logX(
        message: "${UserPreference.getString(PrefKeys.lastEvent)}",
        tag: "lastEventLogOutStatus");*/
  }

  // LoginProfileResponse getUserProfile() {
  //   String? profileData = UserPreference.getString(PrefKeys.userProfile);
  //   return LoginProfileResponse.fromJson(jsonDecode(profileData ?? "{}"));
  // }

  // EmployeePolicyResponseModel? _policyResponseModel;
  //
  // EmployeePolicyResponseModel? get policyResponseModel => _policyResponseModel;

  /*void getEmployeePolicy() {
    String? empPolicyData = UserPreference.getString(PrefKeys.employeePolicy);
    _policyResponseModel =
        EmployeePolicyResponseModel.fromJson(jsonDecode(empPolicyData ?? "{}"));
    if (hasListeners) {
      notifyListeners();
    }
    // return EmployeePolicyResponseModel.fromJson(jsonDecode(empPolicyData ?? "{}"));
  }

  LastEventResponseModel? getLastEvent() {
    String? lastEventData = UserPreference.getString(PrefKeys.lastEvent);
    return LastEventResponseModel.fromJson(jsonDecode(lastEventData ?? "{}"));
  }*/

  // PendingCountsResponseModel ? _pendingCountsResponseModel;
  // PendingCountsResponseModel? get pendingCountsResponseModel => _pendingCountsResponseModel;
  //
  // void getPendingCounts() {
  //   String? pendingCountsData = UserPreference.getString(PrefKeys.pendingCounts);
  //   _pendingCountsResponseModel = PendingCountsResponseModel.fromJson(jsonDecode(pendingCountsData ?? "{}"));
  //   notifyListeners();
  // }

  /*PendingCountsResponseModel? pendingCountsResponseModel;

  void getPendingCounts() {
    String? pendingCountsData =
        UserPreference.getString(PrefKeys.pendingCounts);
    pendingCountsResponseModel = PendingCountsResponseModel.fromJson(
        jsonDecode(pendingCountsData ?? "{}"));
    try {
      if (hasListeners) {
        notifyListeners();
      }
    } catch (e) {}
  }*/

  final Random _random = Random();

  String randomHexString(int length) {
    StringBuffer sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(_random.nextInt(16).toRadixString(16));
    }
    return sb.toString();
  }

/*
  void refreshToken({required Function() success}) {
    updateView(state: CentralViewState.busy);
    ApiService.postRequest(
      url: ApiEndPoints.authLogin,
      data: {
        "client_id":
            kDebugMode ? AppConstants.clientId : AppConstants.prodClientID,
        "client_secret": kDebugMode
            ? AppConstants.clientSecret
            : AppConstants.prodClientSecret,
        "grant_type": "refresh_token",
        "refresh_token": UserPreference.getString(PrefKeys.refreshToken)
      },
      onSuccess: (data) async {
        logX(message: "Response :: $data", tag: "loginSuccess");
        if (data.isNotEmpty) {
          await UserPreference.putString(
              PrefKeys.authToken, data["access_token"]);
          await UserPreference.putBool(PrefKeys.isLogin, true);
          await UserPreference.putString(
              PrefKeys.refreshToken, data["refresh_token"]);
          await UserPreference.putString(
              PrefKeys.expiresIn, data["expires_in"].toString());
          await UserPreference.putString(
              PrefKeys.currentTime, TimeOfDay.now().toString());
        }
        success();
        updateView(state: CentralViewState.idle);
      },
      onError: (error) {
        logX(message: "error.message :: ${error.message}", tag: "loginError");
        logX(message: "error.code :: ${error.code}", tag: "login");
        updateView(state: CentralViewState.idle);
        logout();
        // showSnackBar(
        //   message: error.message ?? "",
        //   state: ToastStats.error,
        // );
      },
    );
  }
*/
}
