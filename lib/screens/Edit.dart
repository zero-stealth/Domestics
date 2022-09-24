import 'dart:developer';

import 'package:domestics/Functions/SettingsFuncs.dart';
import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _dbHelper = DatabaseHelper.instance;
  var data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getInfo() async {
    var info = await _dbHelper.queryAllRows("userInfo");
    setState(() {
      data = info;
    });
  }

  editNameModal(context, token) {
    TextEditingController _fnameController = TextEditingController();
    TextEditingController _lnameController = TextEditingController();

    bool _errorStatus = false;
    String _errorMessage = "";
    String _btnState = 'notloading';

    showModalBottomSheet(
        backgroundColor: dBackgroundWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (
            BuildContext context,
            StateSetter setState,
          ) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.0,
                          height: 4.0,
                          margin: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: const Color(0xff8e8e90).withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "Edit Name",
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Change your first and last name",
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff8e8e90),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    InputWidget(
                      label: "First name",
                      placeholder: "New first name",
                      mycontroller: _fnameController,
                      obscure: false,
                      lines: 1,
                    ),
                    const SizedBox(height: 15.0),
                    InputWidget(
                      label: "Last name",
                      placeholder: "New last name",
                      mycontroller: _lnameController,
                      obscure: false,
                      lines: 1,
                    ),
                    SizedBox(height: _errorStatus == true ? 5.0 : 20.0),
                    ErrorAlert(
                      errorMessage: _errorMessage,
                      status: _errorStatus,
                    ),
                    Container(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: Colors.blueAccent,
                        child: buttonStatus(_btnState, 'Update'),
                        onPressed: () async {
                          setState(() {
                            _errorStatus = false;
                            _btnState = "loading";
                          });

                          var usernameStatus = await checkusername(
                              _fnameController.text.toLowerCase(),
                              _lnameController.text.toLowerCase());

                          if (usernameStatus == false) {
                            return setState(() {
                              _errorMessage = "This name already exists";
                              _errorStatus = true;
                              _btnState = "notloading";
                            });
                          } else {
                            var data = {
                              "fname": "${_fnameController.text.toLowerCase()}",
                              "lname": "${_lnameController.text.toLowerCase()}"
                            };

                            var updated = await updateUserInfo(data, token);

                            if (updated == false) {
                              return setState(() {
                                _errorMessage =
                                    "Update failed. Try again later";
                                _errorStatus = true;
                                _btnState = "notloading";
                              });
                            } else {
                              setState(() {
                                _errorMessage = "";
                                _errorStatus = false;
                                _btnState = "notloading";
                              });

                              Future.delayed(const Duration(seconds: 2), () {
                                getInfo();
                                return Navigator.pop(context);
                              });
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            );
          });
        });
  }

  editModal(context, field, value, subtitle, lines, inputType, token) {
    TextEditingController _myController = TextEditingController();

    bool _errorStatus = false;
    String _errorMessage = "";
    String _buttonState = 'notloading';

    showModalBottomSheet(
        backgroundColor: dBackgroundWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50.0,
                            height: 4.0,
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: const Color(0xff8e8e90).withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        field,
                        style: TextStyle(
                          fontFamily: 'AR',
                          color: Color(0xff262626),
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'SFNSR',
                          color: Color(0xff8e8e90),
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      inputType == "text"
                          ? CupertinoTextField(
                              maxLines: lines,
                              controller: _myController,
                              minLines: lines,
                              padding: const EdgeInsets.all(20.0),
                              placeholder: value,
                              placeholderStyle: TextStyle(
                                fontFamily: "SFNSR",
                                color: dGrey,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff8e8e90).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )
                          : NumberInput(
                              label: "Phone number",
                              placeholder: "New phone number",
                              mycontroller: _myController,
                              obscure: false,
                              focus: false,
                            ),
                      SizedBox(height: _errorStatus == true ? 5.0 : 20.0),
                      ErrorAlert(
                        errorMessage: _errorMessage,
                        status: _errorStatus,
                      ),
                      Container(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: Colors.blueAccent,
                          child: buttonStatus(_buttonState, 'Update'),
                          onPressed: () async {
                            setState(() {
                              _errorStatus = false;
                              _buttonState = "loading";
                            });
                            switch (field) {
                              case "Phone Number":
                                if (_myController.text.length < 9) {
                                  return setState(() {
                                    _buttonState = "notloading";
                                    _errorMessage = "The format is 757690940";
                                    _errorStatus = true;
                                  });
                                }

                                var status = await checkphone(
                                    "254${_myController.text}");

                                if (status == false) {
                                  return setState(() {
                                    _buttonState = "notloading";
                                    _errorMessage =
                                        "Phone number already exists";
                                    _errorStatus = true;
                                  });
                                } else {
                                  var data = {
                                    "phone": "254${_myController.text}",
                                  };

                                  var updated =
                                      await updateUserInfo(data, token);

                                  if (updated == false) {
                                    return setState(() {
                                      _buttonState = "notloading";
                                      _errorMessage = "Update failed";
                                      _errorStatus = true;
                                    });
                                  } else {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      getInfo();
                                      return Navigator.pop(context);
                                    });
                                    break;
                                  }
                                }

                              case "Email":
                                if (_myController.text.length == 0) {
                                  return;
                                }
                                var estatus =
                                    await checkemail(_myController.text);

                                if (estatus == false) {
                                  return setState(() {
                                    _buttonState = "notloading";
                                    _errorMessage = "Email already exists";
                                    _errorStatus = true;
                                  });
                                } else {
                                  var data = {
                                    "email": "${_myController.text}",
                                  };

                                  var updated =
                                      await updateUserInfo(data, token);

                                  if (updated == false) {
                                    return setState(() {
                                      _buttonState = "notloading";
                                      _errorMessage =
                                          "Update failed. Try again later";
                                      _errorStatus = true;
                                    });
                                  } else {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      getInfo();
                                      return Navigator.pop(context);
                                    });
                                    break;
                                  }
                                }

                              case "Bio":
                                if (_myController.text.length == 0) {
                                  return;
                                }

                                var data = {
                                  "bio": "${_myController.text}",
                                };

                                var updated = await updateUserInfo(data, token);

                                if (updated == false) {
                                  return setState(() {
                                    _buttonState = "notloading";
                                    _errorMessage =
                                        "Update failed. Try again later";
                                    _errorStatus = true;
                                  });
                                } else {
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    getInfo();
                                    Navigator.pop(context);
                                    return successModal(context, "Updated bio successfully");
                                  });
                                  break;
                                }

                              default:
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  String capitalize(String s) {
    if(s.length == 0){
      return s;
    } else {
      return s[0].toUpperCase() + s.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            TopControl(
              name: "Edit Profile",
              icon: CupertinoIcons.chevron_back,
              backgroundColor: Colors.transparent,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffafafa),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await editNameModal(context, data[0]['token']);
                              },
                              child: InfoItem(
                                title: "Username",
                                value: data.length <= 0
                                    ? "-"
                                    : "${capitalize(data[0]['fname'])} ${capitalize(data[0]['lname'])}",
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await editModal(
                                  context,
                                  "Email",
                                  "New email address",
                                  "Change your email address",
                                  1,
                                  "text",
                                  data[0]['token'],
                                );
                              },
                              child: InfoItem(
                                title: "Email",
                                value: data.length <= 0 ? "-" : data[0]['email'].toLowerCase(),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await editModal(
                                  context,
                                  "Bio",
                                  "New bio",
                                  "Change your bio",
                                  4,
                                  "text",
                                  data[0]['token'],
                                );
                              },
                              child: InfoItem(
                                title: "Bio",
                                value: data.length <= 0
                                    ? "-"
                                    : capitalize(data[0]['bio']),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await editModal(
                                  context,
                                  "Phone Number",
                                  "New phone number",
                                  "Change your phone number",
                                  4,
                                  "number",
                                  data[0]['token'],
                                );

                                // await getInfo();

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditField(
                                //       lines: 1,
                                //       field: "Phone number",
                                //       subtitle: "Change phone number",
                                //       inputType: "number",
                                //       value: "New phone nnumber",
                                //       token: data[0]['token'],
                                //     ),
                                //   ),
                                // ).then((value) => log("Happy happy"));
                              },
                              child: InfoItem(
                                title: "Phone number",
                                value: data.length <= 0
                                    ? "-"
                                    : "+${data[0]['phone']}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: dBlack,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: dBlack,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Icon(
            CupertinoIcons.chevron_right,
            color: dBlack,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final bool trailing;

  EditItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: color,
              ),
              const SizedBox(width: 20.0),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: color,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          trailing == true
              ? Icon(
                  CupertinoIcons.chevron_right,
                  size: 20.0,
                  color: Color(0xff262626),
                )
              : Container(),
        ],
      ),
    );
  }
}
