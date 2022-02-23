import 'package:practice/obj/credit_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/config/firebase_options.dart';

List<CreditCard> getAllCards() {
  return [];
}

Future<QuerySnapshot> getCollections({required String collectionName}) {
  return FirebaseFirestore.instance.collection(collectionName).get();
}

Future<void> createNewCard(CreditCard newcard) {
  return FirebaseFirestore.instance
      .collection('credit_cards')
      .add(newcard.toJson())
      .then((value) => print("Add user"))
      .catchError((error) => print("Add user failed"));
}
