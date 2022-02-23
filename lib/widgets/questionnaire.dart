import 'package:flutter/material.dart';
import 'package:practice/obj/user_custom.dart';
import 'package:practice/obj/credit_card.dart';
import 'package:practice/widgets/dropdown_cardtype.dart';
import 'package:practice/widgets/partners_checkbox.dart';
import 'package:practice/widgets/advertised_cards.dart';

class Questionnaire extends StatefulWidget {
  final List<CreditCard> creditcards;
  const Questionnaire({Key? key, required this.creditcards}) : super(key: key);

  @override
  State<Questionnaire> createState() => _Questionnaire();
}

class _Questionnaire extends State<Questionnaire> {
  static const List<String> _cardTypes = ['MASTER', 'JCB', 'VISA', '都可以'];
  List<CreditCard> advertisedcards = [];
  void _changeResult() {
    setState(() {
      // advertisedcards = cardSortByHabit(widget.creditcards);
    });
  }

  DropdownCardType dropMenu =
      DropdownCardType(cardTypes: _cardTypes, selectedType: _cardTypes[0]);
  PartnersCheckBox partnersBox = PartnersCheckBox();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: dropMenu,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  // padding: EdgeInsets.all(15),
                ),
                child: partnersBox,
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  // onPressed: _changeResult,
                  onPressed: () {
                    setState(() {
                      UserCustom userCustom = new UserCustom(
                          cardType: dropMenu.getType(),
                          preferedShopping: partnersBox.getPartners());
                      advertisedcards =
                          cardSortByHabit(userCustom, widget.creditcards);
                    });
                  },
                  child: Text(
                    '開始配對',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalDivider(
          color: Colors.black,
          thickness: 3,
          indent: 5,
          endIndent: 5,
          width: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.45,
          child: AdvertisedCards(advertisedCards: advertisedcards),
        ),
      ],
    );
  }

  List<CreditCard> cardSortByHabit(
      UserCustom user, List<CreditCard> candidateCards) {
	 
    // calculate each card's scores
    // sort cards by scores
	Map<String, int> scores = {};
	Map<String, CreditCard> cardMap = {};
	for(CreditCard card in candidateCards) {
		scores[card.name] = calculatePoints(user, card);
		cardMap[card.name] = card;
		print("${card.name} has ${scores[card.name]} on user!");
	}
	List<String> mapKeys = scores.keys.toList(growable: false);
	mapKeys.sort((a, b) => scores[b]!.compareTo(scores[a]!));
	// sort by Map's value
	List<CreditCard> resultCards = mapKeys.map((key) => cardMap[key]!).toList();
    return resultCards;
  }

  int calculatePoints(UserCustom user, CreditCard card) {
  	int scores = 0;
    // currently, only calculate the common items of
    // card'partners and user's preferred shopping
    final Set<String> commonItems =
        user.preferedShopping.toSet().intersection(card.partners.toSet());
	scores = commonItems.length;
	if(user.cardType == '都可以' || user.cardType == card.cardType)
	scores = scores * 5 + 1;
    return scores;
  }
}
