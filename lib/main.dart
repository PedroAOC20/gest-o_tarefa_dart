import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../app/app_module.dart';
import '../app/app_widget.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => AppModule(
            child: const AppWidget(), // Passando o AppWidget como child
          ),
    ),
  );
}
