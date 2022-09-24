import 'dart:developer';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Edit.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditField extends StatefulWidget {
  final String field;
  final String subtitle;
  final int lines;
  final String token;
  final String value;
  final String inputType;

  EditField({
    required this.field,
    required this.subtitle,
    required this.lines,
    required this.token,
    required this.value,
    required this.inputType,
  });

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  TextEditingController _myController = TextEditingController();

  bool _errorStatus = false;
  String _errorMessage = "";
  String _buttonState = 'notloading';

  _addPhone() async {
    if (_myController.text.length < 9) {
      return setState(() {
        _buttonState = "notloading";
        _errorMessage = "The format is 757690940";
        _errorStatus = true;
      });
    }

    var status = checkphone("254${_myController.text}");

    if (status == false) {
      return setState(() {
        _buttonState = "notloading";
        _errorMessage = "Phone number already exists";
        _errorStatus = true;
      });
    } else {
      var data = {
        "phone": "254${_myController.text}",
      };

      var updated = updateUserInfo(data, widget.token);

      if (updated == false) {
        return setState(() {
          _buttonState = "notloading";
          _errorMessage = "Update failed";
          _errorStatus = true;
        });
      } else {
        // Future.delayed(
        //     const Duration(seconds: 4), () {
        //   return Navigator.pop(context);
        // });
        // break;
        // Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Edit(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dWhitePure,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            TopControl(
              name: "Edit ${widget.field}",
              icon: CupertinoIcons.chevron_back,
              backgroundColor: Colors.transparent,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 15.0),
                              widget.inputType == "text"
                                  ? InputWidget(
                                      label: "",
                                      placeholder: widget.value,
                                      mycontroller: _myController,
                                      obscure: false,
                                    )
                                  : NumberInput(
                                      label: "Phone number",
                                      placeholder: "New phone number",
                                      mycontroller: _myController,
                                      obscure: false,
                                      focus: false,
                                    ),
                              SizedBox(
                                  height: _errorStatus == true ? 5.0 : 20.0),
                              ErrorAlert(
                                errorMessage: _errorMessage,
                                status: _errorStatus,
                              ),
                              Container(
                                width: double.infinity,
                                child: CupertinoButton(
                                  color: Colors.blueAccent,
                                  child: buttonStatus(_buttonState, 'Update'),
                                  onPressed: () {
                                    setState(() {
                                      _errorStatus = false;
                                      _buttonState = "loading";
                                    });
                                    switch (widget.field) {
                                      case "Phone number":
                                        _addPhone();
                                        break;
                                      default:
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
