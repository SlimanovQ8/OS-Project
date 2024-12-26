
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class intBloc {}


/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class RadioOption extends intBloc {}
class intB extends Bloc<intBloc, int> {
  /// {@macro counter_bloc}
  intB() : super(0);
}
class IntegerHandler extends Cubit<int> {
  /// {@macro counter_cubit}
  IntegerHandler() : super(0);

  /// Add 1 to the current state.
  void assign(int index) => emit(index);
}
abstract class videoControllerBloc {}


/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class Vid extends videoControllerBloc {}
class VidB extends Bloc<videoControllerBloc, Future> {
  /// {@macro counter_bloc}
  VidB() : super(Future(() {}));
}

abstract class doubleBloc {}


/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class doubleB extends Bloc<doubleBloc, double> {
  /// {@macro counter_bloc}
  doubleB() : super(0);
}