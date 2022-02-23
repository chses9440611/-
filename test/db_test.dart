import 'package:flutter_test/flutter_test.dart';
import 'package:practice/db_controllers.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice/firebase_options.dart';
void main()  async {
	List<String> names = await getPartnersName();
	WidgetsFlutterBinding.ensureInitialized();
  	await Firebase.initializeApp(
    	options: DefaultFirebaseOptions.currentPlatform,
  	);
	for(var name in names) {
		print("${name}");
	}
}
