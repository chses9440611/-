import 'package:flutter/material.dart';

class DropdownCardType extends StatefulWidget {
  String selectedType;
  List<String> cardTypes;
  DropdownCardType(
      {Key? key, required this.selectedType, required this.cardTypes})
      : super(key: key);

  @override
  State<DropdownCardType> createState() => _DropdownCardType();

  String getType() {
    return selectedType;
  }
}

class _DropdownCardType extends State<DropdownCardType> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedType,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "請選擇信用卡種類",
      ),
      items: (widget.cardTypes).map((String cardType) {
        return DropdownMenuItem(
          value: cardType,
          child: Text(cardType),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.selectedType = value!;
        });
      },
    );
  }
}
