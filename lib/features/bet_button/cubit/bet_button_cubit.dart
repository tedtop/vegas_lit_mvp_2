import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bet_button_state.dart';

class BetButtonCubit extends Cubit<BetButtonState> {
  BetButtonCubit() : super(BetButtonInitial());
}
