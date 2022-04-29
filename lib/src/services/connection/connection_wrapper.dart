import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/routes.dart';
import 'package:upwind/src/services/connection/bloc/connection_bloc.dart';

BlocListener connectionWrapper({required AppRouter router}) {
  return BlocListener<ConnectionBloc, ConnectionState>(
    listener: (context, state) {
      switch (state.status) {
        case ConnectionStatus.connected:
          if (router.current.path == Routes.noConnection.absolutePath) {
            router.pop();
          }
          break;
        case ConnectionStatus.disconnected:
          router.pushNamed(Routes.noConnection.generatePath());
          break;
        default:
          break;
      }
    },
  );
}
