import 'package:flutter/cupertino.dart';
import 'package:flutter_lesson/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CupertinoStoreApp(),
    ),
  );
}
