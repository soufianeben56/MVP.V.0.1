import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

typedef OnSuccess = Function();
typedef OnError = Function(dynamic);

extension BLEDevice on BluetoothDevice {
  Future<void> requestMTU() async {
    if (Platform.isAndroid) {
      await requestMtu(512, predelay: 0);
    } else if (Platform.isIOS) {
      await requestMtu(185, predelay: 0);
    }
  }

  Future<void> connectDevice({
    required OnSuccess onSuccess,
    required OnError onError,
    Duration timeOut = const Duration(seconds: 35),
  }) async {
    try {
      await connect(mtu: null, timeout: timeOut).then((value) async {
        if (Platform.isAndroid) {
          await requestMTU();
        }
        await discoverServices();
        onSuccess();
      });
    } catch (e) {
      onError(e);
    }
  }

  Future<void> disconnectDevice({
    required OnSuccess onSuccess,
    required OnError onError,
  }) async {
    try {
      await disconnect().whenComplete(() {
        onSuccess();
      });
    } catch (e) {
      onError(e);
    }
  }
}
