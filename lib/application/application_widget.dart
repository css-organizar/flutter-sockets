import 'package:appclient/presentation/views/launcher/launcher.dart';
import 'package:flutter/material.dart';

class ApplicationWidget extends StatefulWidget {
  const ApplicationWidget({Key? key}) : super(key: key);

  @override
  State<ApplicationWidget> createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LauncherPage(),
    );
  }
}
