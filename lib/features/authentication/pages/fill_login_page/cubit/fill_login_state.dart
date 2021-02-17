part of 'fill_login_cubit.dart';

abstract class FillLoginState extends Equatable {
  const FillLoginState();

  @override
  List<Object> get props => [];
}

class FillLoginInitial extends FillLoginState {}

class FillLoginInProgress extends FillLoginState {}

class FillLoginSuccess extends FillLoginState {}

class FillLoginFailure extends FillLoginState {}
