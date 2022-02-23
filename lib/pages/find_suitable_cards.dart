import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/widgets/questionnaire.dart';
import 'package:practice/obj/credit_card.dart';

class FindSuitableCards extends StatelessWidget {
  FindSuitableCards({Key? key}) : super(key: key);
  List<CreditCard> creditcards = [];
  static String cardsCollect = 'credit_cards';
  Future<QuerySnapshot> getCards() {
    var snapshot = FirebaseFirestore.instance
        .collection(cardsCollect)
        .withConverter<CreditCard>(
          fromFirestore: (snapshot, _) => CreditCard.fromJson(snapshot.data()!),
          toFirestore: (card, _) => card.toJson(),
        )
        .get();
    snapshot.then((collect) {
      creditcards = collect.docs.map((doc) => doc.data()).toList();
    });
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片速配調查'),
      ),
      body: FutureBuilder(
          future: getCards(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // return Text("testing");
            if (creditcards != [])
              return Questionnaire(creditcards: creditcards);
            else
              return Text('Loading...');
          }),
    );
  }
}
