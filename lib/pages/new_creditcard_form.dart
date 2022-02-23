import 'package:flutter/material.dart';
import 'package:practice/obj/credit_card.dart';
import 'package:practice/widgets/dropdown_cardtype.dart';
import 'package:practice/widgets/partners_checkbox.dart';
import 'package:practice/widgets/db_controllers.dart';
import 'package:practice/widgets/test_text.dart';

class NewCreditCardForm extends StatefulWidget {
  const NewCreditCardForm({Key? key}) : super(key: key);

  @override
  State<NewCreditCardForm> createState() => _NewCreditCardForm();
}

class _NewCreditCardForm extends State<NewCreditCardForm> {
  // create the form key
  final _formKey = GlobalKey<FormState>();

  Widget myText(String content) {
    return Container(
      child: Text(
        content,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      margin: EdgeInsets.all(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _urlController = TextEditingController();
    final selectPartners = myText('選擇信用卡合作商家');
    const _cardTypes = ['MASTER', 'JCB', 'VISA'];
    CreditCard newCard;
    DropdownCardType dropMenu =
        DropdownCardType(cardTypes: _cardTypes, selectedType: _cardTypes[0]);
    PartnersCheckBox partnersBox = PartnersCheckBox();
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增信用卡'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: MediaQuery.of(context).size.height * 0.12,
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "請輸入信用卡名稱",
                  hintText: "iLEO測試信用卡",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter credit card name!';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: MediaQuery.of(context).size.height * 0.12,
              child: TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "請輸入申請連結",
                  hintText: "https://google.com",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the application name!';
                  }
                  return null;
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: dropMenu,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: partnersBox,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Text('Submit'),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        newCard = CreditCard(
                            name: _nameController.text,
                            url: _urlController.text,
                            cardType: dropMenu.getType(),
                            partners: partnersBox.getPartners());
                        print(newCard.name);
                        print(newCard.url);
                        print(newCard.cardType);
                        print(newCard.partners);
                        if (_formKey.currentState!.validate()) {
                          createNewCard(newCard);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('卡片新增完成')),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text('Cancel'),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
