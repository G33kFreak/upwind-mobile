import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/services/hive.dart';
import 'package:upwind/src/services/sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart' hide SentryClient;

import 'src/app.dart';

Future<void> main() => boot(); //bootWithSentry();

Future<void> boot() async {
  await setupHive();
  runApp(MyApp());
}

Future<void> bootWithSentry() async {
  await setupHive();
  return SentryFlutter.init(
    configureSentry,
    appRunner: () {
      BlocOverrides.runZoned(
        () => runApp(MyApp()),
        blocObserver: SentryBlocObserver(
          sentryIntegration: SentryClient(),
        ),
      );
    },
  );
}
