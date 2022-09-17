import 'dart:developer';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final _dbHelper = DatabaseHelper.instance;
  TextEditingController _phoneController = TextEditingController();

  bool _errorStatus = false;
  String _errorMessage = "";
  String _buttonState = 'notloading';

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBackgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: dBlueBackground,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.phone_fill,
                      size: 60.0,
                      color: dWhitePure,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  "Phone Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFD-Bold',
                    fontSize: 22.0,
                    color: dBlueBackground,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "People will use this number to contact you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SFT-Regular',
                    fontSize: 16.0,
                    color: dBlackFaded,
                  ),
                ),
                NumberInput(
                  label: "",
                  placeholder: "757690940",
                  mycontroller: _phoneController,
                  obscure: false,
                ),
                SizedBox(height: _errorStatus == true ? 5.0 : 15.0),
                ErrorAlert(
                  errorMessage: _errorMessage,
                  status: _errorStatus,
                ),
                const SizedBox(height: 5.0),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: CupertinoButton(
                    color: dBlueBackground,
                    child: buttonStatus(_buttonState, 'Continue'),
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      if (_phoneController.text.length < 9) {
                        return setState(() {
                          _buttonState = "notloading";
                          _errorMessage = "The format is 757690940";
                          _errorStatus = true;
                        });
                      }

                      var myPhone = "254${_phoneController.text}";

                      if (_phoneController.text.length <= 0) {
                        setState(() {
                          _buttonState = "notloading";
                          _errorMessage = "Enter a valid phone number";
                          _errorStatus = true;
                        });
                      } else {
                        setState(() {
                          _buttonState = "loading";
                          _errorStatus = false;
                        });

                        var info = await _dbHelper.queryAllRows("userInfo");

                        var data = {
                          "phone": myPhone,
                        };

                        var valid = await checkphone(myPhone);

                        if (valid == false) {
                          return setState(() {
                            _buttonState = "notloading";
                            _errorMessage = "This phone number already exists.";
                            _errorStatus = true;
                          });
                        }

                        var status =
                            await updateUserInfo(data, info[0]['token']);

                        switch (status) {
                          case false:
                            setState(() {
                              _buttonState = "notloading";
                              _errorMessage = "Action failed";
                              _errorStatus = true;
                            });
                            break;

                          case true:
                            log("Success");
                            setState(() {
                              _buttonState = "notloading";
                              _errorStatus = false;
                            });
                            break;
                          default:
                        }
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Selections()),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
