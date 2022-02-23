import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnersCheckBox extends StatefulWidget {
  Map<String, bool> optionsMap = {};

  PartnersCheckBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PartnersBoxState();

  List<String> getPartners() {
    List<String> partners = <String>[];
    optionsMap.forEach((partner, status) {
      if (status) {
        partners.add(partner);
      }
    });
    return partners;
  }
}

class _PartnersBoxState extends State<PartnersCheckBox> {
  static String collectionName = 'partner_stores';
  final ScrollController _firstController = ScrollController();
  late Future<QuerySnapshot> _getStores;
  @override
  void initState() {
    _getStores = getStores();
    super.initState();
  }

  Future<QuerySnapshot> getStores() {
    var snapshot = FirebaseFirestore.instance.collection(collectionName).get();

    snapshot.then((doc) {
      doc.docs.forEach((store) {
        widget.optionsMap[store["name"]] = false;
      });
    });
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    List<CheckboxListTile> partnersList = <CheckboxListTile>[];
    return FutureBuilder(
        future: _getStores,
        builder: (context, snapshot) {
          if (partnersList != []) {
            widget.optionsMap.forEach((partner, status) {
              partnersList.add(CheckboxListTile(
                title: Text(partner, style: TextStyle(fontSize: 16)),
                value: status,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (newValue) {
                  setState(() {
                    widget.optionsMap[partner] = newValue!;
                  });
                },
              ));
            });
          }
          return Column(
            children: [
              Text(
                '請選擇合作夥伴',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _firstController,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: _firstController,
                      itemCount: partnersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: partnersList[index],
                        );
                      }),
                ),
              ),
            ],
          );
        });
  }
}
