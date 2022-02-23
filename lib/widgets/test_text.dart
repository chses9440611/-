import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestText extends StatelessWidget {
  TestText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference stores =
        FirebaseFirestore.instance.collection('partner_stores');

    return FutureBuilder<QuerySnapshot>(
      future: stores.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        //if (snapshot.hasData && !snapshot.requireData.exists) {
        //  return Text("Document does not exist");
        // }

        //if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          //Map<String, dynamic> data =
          // snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['name']} ${data['last_name']}");
          snapshot.data!.docs.forEach((doc) {
            print(doc["name"]);
          });
          return Text("Connect done");
        }

        return Text("loading");
      },
    );
  }
}
