import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<T extends AppEvent, E extends AppState>
    extends Bloc<T, E> {
  BaseBloc(E initialState) : super(initialState);
}


abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}


class AppState extends Equatable {
  @override
  List<Object> get props => [];
}
