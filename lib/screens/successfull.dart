import 'package:flutter/material.dart';

class SuccessfullScreen extends StatelessWidget {
  const SuccessfullScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Center(
              child: Text(
                'successfull Registeration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
