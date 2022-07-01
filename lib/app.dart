import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lesson/home.dart';

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return const CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: CupertinoStoreHomePage(),
    );
  }
}
