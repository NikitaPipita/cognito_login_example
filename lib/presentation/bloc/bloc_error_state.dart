import 'package:meta/meta.dart';

@immutable
abstract class BlocErrorState {
  final Object? error;

  const BlocErrorState._(this.error);
}
