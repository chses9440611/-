import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:practice/obj/credit_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisedCards extends StatelessWidget {
  List<CreditCard> advertisedCards;
  AdvertisedCards({Key? key, required this.advertisedCards}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return advertisedCards.length > 0
        ? ListView.builder(
            itemCount: advertisedCards.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return customCard(advertisedCards[index]);
            })
        : Center(
            child: Text(
              '填寫左邊的問券來找出最適合的信用卡吧！',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
  }

  Card customCard(CreditCard card) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text(card.name),
            subtitle: Text(card.cardType),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                  text: '申辦連結',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await launch(card.url);
                    },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
