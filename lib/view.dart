import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';

class SphereMapWidget extends StatefulWidget {
  final String apiKey;
  final String bundleId;

  const SphereMapWidget(
      {required this.apiKey, required this.bundleId, Key? key})
      : super(key: key);

  @override
  SphereMapState createState() => SphereMapState();
}

class SphereMapState extends State<SphereMapWidget> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
        _load();
      },
    );
  }

  void _load() async {
    // get html
    String content = await rootBundle
        .loadString("packages/sphere_maps_flutter/assets/index.html");
    // set api key
    content = content.replaceFirst("[YOUR_API_KEY]", widget.apiKey);
    content = content.replaceFirst(
        "[YOUR_SECRET_API_KEY]", "${widget.apiKey.substring(0, 8)}...");
    // set application id
    content = content.replaceFirst("[YOUR_BUNDLE_ID]", widget.bundleId);
    // load
    _controller.loadHtmlString(content, baseUrl: "http://${widget.bundleId}/");
  }

  Object SphereStatic(String type, String name) => {
        "\$static": type,
        "name": name,
      };

  Object SphereObject(
    String type, {
    String? id,
    List<Object>? args,
  }) =>
      {
        "\$object": type,
        "\$id": id ?? DateTime.now().millisecondsSinceEpoch,
        "args": args ?? [],
      };

  Object call(
    method, {
    List<Object>? args,
  }) async {
    String data = await _controller.runJavascriptReturningResult(
        "call('" + method + "','" + json.encode(args ?? []) + "');");
    return json.decode(data);
  }

  Object objectCall(
    obj,
    method, {
    List<Object>? args,
  }) async {
    String data = await _controller.runJavascriptReturningResult(
        "objectCall('" +
            json.encode(obj) +
            "' ,'" +
            method +
            "' ,'" +
            json.encode(args ?? []) +
            "');");
    return json.decode(data);
  }
}
