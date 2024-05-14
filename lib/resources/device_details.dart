import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

class DeviceDetails {
  static Future<DeviceInformation> getAppDetails() async {
    var deviceInfo = DeviceInfoPlugin();
    String id;
    String deviceName;

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor!;
      deviceName = iosDeviceInfo.name;
      print(iosDeviceInfo.name);
      print(iosDeviceInfo.model);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id;
      deviceName = androidDeviceInfo.device;
      print("device name ${androidDeviceInfo.device}");
      print("model ${androidDeviceInfo.brand}");
    } else {
      id = 'null';
      deviceName = 'null';
    }

    print('id $id');
    print('device name $deviceName');

    return DeviceInformation(id, deviceName);
  }
}

class DeviceInformation {
  final String id;
  final String deviceName;

  DeviceInformation(this.id, this.deviceName);
}