part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class Connected extends InternetState {
  final String message;
  const Connected({required this.message});
  @override
  List<Object> get props => [message];
}

class Disconnected extends InternetState {
  final String errorMessage;
  const Disconnected({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
