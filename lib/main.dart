import 'package:blnk_task/provider/user_provider.dart';
import 'package:blnk_task/screens/registeration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'apis/googleSheetsAPI.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UsersSheetApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RegisterProvider(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text('BLNK TASK'),
              backgroundColor: Colors.black,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              foregroundColor: Colors.red,
            ),
            body: Register(),
          ),
        ));
  }
}
