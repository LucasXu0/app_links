// This file was generated using the following command and may be overwritten.
// dart-dbus generate-object dbus-interface.xml

import 'package:dbus/dbus.dart';

class DBusInterfaceObject extends DBusObject {
  /// Creates a new object to expose on [path].
  DBusInterfaceObject({
    // It should be compatible with the node name in dbus-interface.xml
    required String objectId,
    required this.interfaceId,
    this.onOpen,
    this.onActive,
    this.onActivateAction,
  }) : super(DBusObjectPath.unchecked(objectId));

  final Future<void> Function(
    List<String> uris,
    Map<String, DBusValue> platformData,
  )? onOpen;
  final Future<void> Function(Map<String, DBusValue> platformData)? onActive;
  final Future<void> Function(
    String actionName,
    List<DBusValue> parameter,
    Map<String, DBusValue> platformData,
  )? onActivateAction;

  /// The format should be xxx.yyy.zzz, which is compatible with the interface name dbus-interface.xml
  final String interfaceId;

  /// Implementation of com.example.FlutterApp.Activate()
  Future<DBusMethodResponse> doActivate(
      Map<String, DBusValue> platformData) async {
    try {
      await onActive?.call(platformData);
      return DBusMethodSuccessResponse();
    } catch (e) {
      return DBusMethodErrorResponse.failed(e.toString());
    }
  }

  /// Implementation of com.example.FlutterApp.Open()
  Future<DBusMethodResponse> doOpen(
    List<String> uris,
    Map<String, DBusValue> platformData,
  ) async {
    try {
      await onOpen?.call(uris, platformData);
      return DBusMethodSuccessResponse();
    } catch (e) {
      return DBusMethodErrorResponse.failed(e.toString());
    }
  }

  /// Implementation of com.example.FlutterApp.ActivateAction()
  Future<DBusMethodResponse> doActivateAction(
    String actionName,
    List<DBusValue> parameter,
    Map<String, DBusValue> platformData,
  ) async {
    try {
      await onActivateAction?.call(actionName, parameter, platformData);
      return DBusMethodSuccessResponse();
    } catch (e) {
      return DBusMethodErrorResponse.failed(e.toString());
    }
  }

  @override
  List<DBusIntrospectInterface> introspect() {
    return [
      DBusIntrospectInterface(interfaceId, methods: [
        DBusIntrospectMethod('Activate', args: [
          DBusIntrospectArgument(
              DBusSignature('a{sv}'), DBusArgumentDirection.in_,
              name: 'platform_data')
        ]),
        DBusIntrospectMethod('Open', args: [
          DBusIntrospectArgument(DBusSignature('as'), DBusArgumentDirection.in_,
              name: 'uris'),
          DBusIntrospectArgument(
              DBusSignature('a{sv}'), DBusArgumentDirection.in_,
              name: 'platform_data')
        ]),
        DBusIntrospectMethod('ActivateAction', args: [
          DBusIntrospectArgument(DBusSignature('s'), DBusArgumentDirection.in_,
              name: 'action_name'),
          DBusIntrospectArgument(DBusSignature('av'), DBusArgumentDirection.in_,
              name: 'parameter'),
          DBusIntrospectArgument(
              DBusSignature('a{sv}'), DBusArgumentDirection.in_,
              name: 'platform_data')
        ])
      ])
    ];
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall methodCall) async {
    if (methodCall.interface == interfaceId) {
      if (methodCall.name == 'Activate') {
        if (methodCall.signature != DBusSignature('a{sv}')) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doActivate(methodCall.values[0].asStringVariantDict());
      } else if (methodCall.name == 'Open') {
        if (methodCall.signature != DBusSignature('asa{sv}')) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doOpen(methodCall.values[0].asStringArray().toList(),
            methodCall.values[1].asStringVariantDict());
      } else if (methodCall.name == 'ActivateAction') {
        if (methodCall.signature != DBusSignature('sava{sv}')) {
          return DBusMethodErrorResponse.invalidArgs();
        }
        return doActivateAction(
            methodCall.values[0].asString(),
            methodCall.values[1].asVariantArray().toList(),
            methodCall.values[2].asStringVariantDict());
      } else {
        return DBusMethodErrorResponse.unknownMethod();
      }
    } else {
      return DBusMethodErrorResponse.unknownInterface();
    }
  }

  @override
  Future<DBusMethodResponse> getProperty(String interface, String name) async {
    if (interface == interfaceId) {
      return DBusMethodErrorResponse.unknownProperty();
    } else {
      return DBusMethodErrorResponse.unknownProperty();
    }
  }

  @override
  Future<DBusMethodResponse> setProperty(
      String interface, String name, DBusValue value) async {
    if (interface == interfaceId) {
      return DBusMethodErrorResponse.unknownProperty();
    } else {
      return DBusMethodErrorResponse.unknownProperty();
    }
  }
}
