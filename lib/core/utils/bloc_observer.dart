import 'package:kyo_base/imports/base_component_import.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    logger.i('onCreate -- ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.i(
        'onEvent -- ${bloc.runtimeType}, Event: ${event.runtimeType}, message: ${event.toString()}');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    logger.i(
        'onEvent -- ${bloc.runtimeType}, CurrentState: {State: ${change.currentState}, message: ${change.currentState.toString()}}, '
            'NextState: {State: ${change.nextState}, message: ${change.nextState.toString()}}');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.i('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
