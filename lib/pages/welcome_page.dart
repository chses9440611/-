import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text('歡迎來到信用卡分類帽系統'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  print("Goto investigate!");
                  Navigator.pushNamed(context, '/find_suitable_cards');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "找出適合您的卡",
                      style: TextStyle(
                        color: Colors.indigo[800],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              color: Colors.black,
              thickness: 6,
              indent: 20,
              endIndent: 0,
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/newCard');
                },
                child: Tooltip(
                  message: "新增一張信用卡",
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '新增一張信用卡',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
