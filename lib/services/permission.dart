import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Map<PermissionGroup, PermissionStatus> permissions;
  final PermissionHandler _permissionHandler = PermissionHandler();
  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _hasContactsPermission() async {
    return hasPermission(PermissionGroup.contacts);
  }

  Future<bool> _hasPhonePermission() async {
    return hasPermission(PermissionGroup.phone);
  }

  Future<bool> getPhonePermission() async {
    if (!await _hasContactsPermission()) {
      permissions = await PermissionHandler().requestPermissions([
        PermissionGroup.contacts,
      ]);
      print(permissions);
    } else {
      return true;
    }
    return (permissions[PermissionGroup.contacts] == PermissionStatus.granted);
  }

  Future<bool> getContactPermission() async {
    if (!await _hasPhonePermission()) {
      permissions = await PermissionHandler().requestPermissions([
        PermissionGroup.phone,
      ]);
      print(permissions);
    } else {
      return true;
    }
    return (permissions[PermissionGroup.phone] == PermissionStatus.granted);
  }
}
