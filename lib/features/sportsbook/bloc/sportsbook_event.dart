part of 'sportsbook_bloc.dart';

abstract class SportsbookEvent extends Equatable {
  const SportsbookEvent();

  @override
  List<Object> get props => [];
}

class SportsbookOpen extends SportsbookEvent {}
