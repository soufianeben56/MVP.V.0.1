import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../exports.dart';

class CommonUtils {
  static unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<void> urlLauncher(String url) async {
    Uri? uri = Uri.tryParse(
      url.replaceAll("www.", "https://"),
    );

    if (url.isValidUrl() && uri != null && await canLaunchUrl(uri)) {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } else {
      throw Exception('Could not launch $url');
    }
  }

  static void displayToast(
    String? message, {
    Duration? duration,
    Function()? onDismiss,
    ToastStats state = ToastStats.info,
  }) {
    showToast(message ?? "",
        duration: duration ?? const Duration(milliseconds: 1500),
        position: ToastPosition.top,
        backgroundColor: state.toastColor(),
        radius: 15,
        margin: EdgeInsets.zero,
        textPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.relativeWidth(5),
          vertical: SizeConfig.relativeHeight(1),
        ),
        constraints: BoxConstraints(maxWidth: SizeConfig.relativeWidth(90)),
        textStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.white,
        ),
        onDismiss: onDismiss);
  }

  static Future<PaletteGenerator> updatePaletteGenerator(String path) async {
    return await PaletteGenerator.fromImageProvider(
      Image.network(path).image,
    );
  }

  static Future<bool> getLocation() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    late LocationPermission permission;

    if (isLocationEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          // openAppSettings();
          return false;
        }
        if (permission == LocationPermission.denied) {
          return false;
        }
      } else {
        return true;
      }
    } else {
      Geolocator.openLocationSettings();
      return false;
    }
    return false;
  }

  // static Future<FilePickerResult?> pickFile() async {
  //   return await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'jpeg', 'gif', 'png', 'mp4', 'mkv'],
  //     allowCompression: true,
  //     compressionQuality: 50,
  //     allowMultiple: false,
  //   );
  // }

  static Future<String> getAppDirectory() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory appDirectory = Directory('${directory.path}/VOYD');
    if (!(await appDirectory.exists())) {
      log("creating the directory", name: "getAppDirectory");
      await appDirectory.create();
    }
    log("Directory  is exist", name: "getAppDirectory");

    return appDirectory.path;
  }

  static Future<File> saveFile(File file) async {
    final appDirectory = await getAppDirectory();
    final fileName = file.uri.pathSegments.last;
    final newPath = '$appDirectory/$fileName';
    log("Saving File Path : $newPath", name: "saveFile");

    return file.copy(newPath);
  }

  // static Future<void> readSettings() async {
  //   BLEReadSettingsResponseModel? readSettings =
  //       await BLEService.instance.readSettingsData();
  //   IsarHelper isarHelper = IsarHelper.instance;
  //   if (readSettings != null) {
  //     isarHelper.isar?.writeTxn(() async {
  //       await isarHelper.settingsDb?.clear();
  //     });
  //     final data = SettingDBModel()
  //       ..userId = ""
  //       ..dateFormat = readSettings.dateFormat ?? ""
  //       ..date = DateTime.now()
  //       ..fontColor = readSettings.fontColor?.hex ?? ""
  //       ..clockFormat = readSettings.clockFormat ?? ""
  //       ..timeFormat = readSettings.timeFormat ?? ""
  //       ..timeZone = readSettings.timeZone ?? ""
  //       ..syncCode = ""
  //       ..syncId = "";
  //     await isarHelper.writeTxn(
  //       data: data,
  //       collection: isarHelper.settingsDb,
  //       type: DBQueryEnum.write,
  //       onSuccess: (data) async {},
  //       onError: (p0) {
  //         log(p0.toString(), name: "Write Error Ops");
  //       },
  //     );
  //     log(" ${readSettings.toJson()}", name: "settings data");
  //   }
  // }

  static void logX(
    String? message,
    String name, {
    StackTrace? stackTrace,
    Object? error,
    int? sequenceNumber,
  }) {
    log(
      message ?? "",
      name: name,
      stackTrace: stackTrace,
      error: error,
      time: DateTime.now(),
      sequenceNumber: sequenceNumber,
    );
  }
}
