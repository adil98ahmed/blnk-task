import 'package:blnk_task/provider/user_provider.dart';
import 'package:blnk_task/screens/successfull.dart';
import 'package:blnk_task/widgets/textField_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController mobileController = TextEditingController();

class _SignUpState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: .5)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'USER REGESERATION',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          TextFieldWidget(
                              controller: firstNameController,
                              lable: "First Name",
                              passwordEncryption: false,
                              hint: "Enter Your First Name"),
                          TextFieldWidget(
                              controller: lastNameController,
                              lable: "Last Name",
                              passwordEncryption: false,
                              hint: "Enter Your Last Name"),
                          TextFieldWidget(
                              controller: addressController,
                              lable: "Address",
                              passwordEncryption: false,
                              hint: "Enter Your Address"),
                          TextFieldWidget(
                              controller: mobileController,
                              lable: "Mobile",
                              passwordEncryption: false,
                              hint: "Enter Your Mobile"),
                          Consumer<RegisterProvider>(
                            builder: (context, value, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Front ID',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<RegisterProvider>()
                                            .takePhoto('front');
                                        value.readTextFromImage();
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        height: 50,
                                        child: (value.user.frontIdImage == null)
                                            ? Image(
                                                image:
                                                    AssetImage('assets/a.png'))
                                            : FittedBox(
                                                fit: BoxFit.fill,
                                                child: Image.file(
                                                    value.user.frontIdImage)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Back ID',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<RegisterProvider>()
                                            .takePhoto('back');
                                      },
                                      child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          height: 50,
                                          child: (value.user.backIdImage ==
                                                  null)
                                              ? Image(
                                                  image: AssetImage(
                                                      'assets/a.png'))
                                              : FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Image.file(
                                                      value.user.backIdImage))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Consumer<RegisterProvider>(
                                builder: (context, value, child) => Text(
                                  (value.user.id == null)
                                      ? 'Your National ID'
                                      : (value.user.id == "-1")
                                          ? "Try Again"
                                          : value.user.id,
                                  style: TextStyle(
                                      color: (value.user.id == null ||
                                              value.user.id != "-1")
                                          ? Colors.white30
                                          : Colors.red),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          ),
                          Consumer<RegisterProvider>(
                            builder: (context, value, child) => Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    value.user.firstName =
                                        firstNameController.text;
                                    value.user.lastName =
                                        lastNameController.text;
                                    value.user.address = addressController.text;
                                    value.user.mobile = mobileController.text;
                                    var registered = await value.register();

                                    if (registered) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SuccessfullScreen()),
                                      );
                                    }
                                    value.uploadImage();
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>((_) {
                                      return RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero);
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'I have already account ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.blue[300],
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<RegisterProvider>(
              builder: (context, value, child) => (value.wait)
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * .4,
                      left: MediaQuery.of(context).size.width * .40,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
