part of 'sportsbook_bloc.dart';

abstract class SportsbookState extends Equatable {
  const SportsbookState();

  @override
  List<Object> get props => [];
}

class SportsbookInitial extends SportsbookState {}

class SportsbookOpened extends SportsbookState {}
