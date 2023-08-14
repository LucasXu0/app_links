import 'dart:async';

import 'package:app_links/src/linux/dbus_interface.dart';
import 'package:dbus/dbus.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:app_links/src/app_links_platform_interface.dart';

class AppLinkPluginLinux extends AppLinksPlatform {
  static void registerWith(Registrar registrar) {
    AppLinksPlatform.instance = AppLinkPluginLinux();
  }

  final _client = DBusClient.session();
  DBusInterfaceObject? _object;
  final StreamController<String> _controller = StreamController<String>();
  final List<String> _uris = [];

  @override
  void registerDBusService(String objectId, String interfaceId) {
    if (_object != null) {
      _client.unregisterObject(_object!);
      _object = null;
    }

    _object = DBusInterfaceObject(
      objectId: objectId,
      interfaceId: interfaceId,
      onOpen: (uris, platformData) async {
        _uris
          ..clear()
          ..addAll(uris);

        if (uris.isNotEmpty) {
          _controller.add(uris.last);
        }
      },
    );
    _client
      ..requestName(interfaceId)
      ..registerObject(_object!);
  }

  @override
  Future<Uri?> getInitialAppLink() async {
    return getInitialAppLinkString().then(
      (value) => value != null ? Uri.parse(value) : null,
    );
  }

  @override
  Future<String?> getInitialAppLinkString() async {
    return _uris.isNotEmpty ? _uris.first : null;
  }

  @override
  Future<Uri?> getLatestAppLink() async {
    return getLatestAppLinkString().then(
      (value) => value != null ? Uri.parse(value) : null,
    );
  }

  @override
  Future<String?> getLatestAppLinkString() async {
    return _uris.isNotEmpty ? _uris.last : null;
  }

  @override
  Stream<String> get stringLinkStream => _controller.stream;

  @override
  Stream<Uri> get uriLinkStream => _controller.stream.map(Uri.parse);
}
