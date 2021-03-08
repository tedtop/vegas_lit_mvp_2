import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OpenBets extends Equatable {
  OpenBets({
    this.amount,
    this.away,
    this.home,
    this.id,
    this.type,
    this.mlAmount,
    this.win,
  });

  final int amount;
  final String away;
  final String home;
  final String id;
  final String type;
  final int win;
  final int mlAmount;

  factory OpenBets.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return OpenBets(
      id: documentSnapshot.id,
      amount: data['amount'] as int,
      away: data['away'] as String,
      home: data['home'] as String,
      type: data['type'] as String,
      win: data['win'] as int,
      mlAmount: data['ml_amount'] as int,
    );
  }

  @override
  List<Object> get props {
    return [
      amount,
      away,
      home,
      id,
      type,
      mlAmount,
      win,
    ];
  }
}
