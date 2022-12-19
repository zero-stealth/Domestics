import 'dart:developer';
import 'dart:io';

import 'package:domestics/Functions/SettingsFuncs.dart';
import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/Functions/requests.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:domestics/widgets/TagsView.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:domestics/widgets/settings/StatusPill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import '../controllers/user_controller.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _dbHelper = DatabaseHelper.instance;
  var controller = Get.put(UserController());
  var data = [];
  var workerTags = [];
  var clientTags = [];
  ImagePicker picker = ImagePicker();
  XFile? image;

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
    var wkr = await _dbHelper.queryAllRows("workerTags");
    var clnt = await _dbHelper.queryAllRows("clientTags");

    setState(() {
      data = info;
      workerTags = wkr;
      clientTags = clnt;
    });
  }

  _clientTagsModal(context, token, workerTgs) {
    TextEditingController _tagController = TextEditingController();
    //var _pickedTags = workerTgs;
    var _myTags = [...clientTags];
    var _btnState = "notloading";
    var _toDelete = [];
    var _toAdd = [];

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
                      "Add client tags",
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Tags for the services you are looking for",
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff8e8e90),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // TagsView(
                    //   tags: _pickedTags.length <= 0 ? [] : _pickedTags,
                    //   showMark: true,
                    // ),
                    // const SizedBox(height: 15.0),
                    TagsView(
                      tags: _myTags.length <= 0 ? [] : _myTags,
                      showMark: true,
                      token: token,
                      toDelete: _toDelete,
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: dGreyFaded,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: CupertinoTextField(
                        obscureText: false,
                        controller: _tagController,
                        scrollPhysics: const BouncingScrollPhysics(),
                        style: TextStyle(
                          color: dBlack,
                          fontFamily: 'SFNSR',
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              _myTags.add({"tag": _tagController.text});
                              _toAdd.add(_tagController.text);
                              _tagController.text = "";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: dBlueBackground,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontFamily: "AR",
                                color: dWhitePure,
                                fontSize: 14.0,
                              ),
                            ),
                            // Icon(
                            //   CupertinoIcons.paperplane_fill,
                            //   color: dWhitePure,
                            //   size: 20.0,
                            // ),
                          ),
                        ),
                        maxLines: 1,
                        placeholder: "painter",
                        placeholderStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontFamily: 'SFNSR',
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: Colors.blueAccent,
                        child: buttonStatus(_btnState, 'Update'),
                        onPressed: () async {
                          setState(() {
                            _btnState = "loading";
                          });

                          for (var i = 0; i < _toDelete.length; i++) {
                            var status = await deleteClientTags(
                                _toDelete[i]['id'], token);

                            if (status == false) {
                              log("Failed to delete: ${_toDelete[i]['id']}");
                            }
                          }

                          var status = await uploadClientTags(_toAdd, token);

                          if (status == false) {
                            log("Failed to delete: $_toAdd");
                          }

                          await populateData();
                          await getInfo();

                          setState(() {
                            _btnState = "notloading";
                          });

                          Navigator.pop(context);

                          successModal(
                              context, "Client tags updated successfully");
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
      },
    );
  }

  _workerTagsModal(context, token, workerTgs) {
    TextEditingController _tagController = TextEditingController();
    //var _pickedTags = workerTgs;
    var _myTags = [...workerTags];
    var _btnState = "notloading";
    var _toDelete = [];
    var _toAdd = [];

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
                      "Add worker tags",
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Tags for the services you offer",
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff8e8e90),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // TagsView(
                    //   tags: _pickedTags.length <= 0 ? [] : _pickedTags,
                    //   showMark: true,
                    // ),
                    // const SizedBox(height: 15.0),
                    TagsView(
                      tags: _myTags.length <= 0 ? [] : _myTags,
                      showMark: true,
                      token: token,
                      toDelete: _toDelete,
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: dGreyFaded,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: CupertinoTextField(
                        obscureText: false,
                        controller: _tagController,
                        scrollPhysics: const BouncingScrollPhysics(),
                        style: TextStyle(
                          color: dBlack,
                          fontFamily: 'SFNSR',
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            print(_myTags);
                            setState(() {
                              _myTags.add({"tag": _tagController.text});
                              _toAdd.add(_tagController.text);
                              _tagController.text = "";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: dBlueBackground,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontFamily: "AR",
                                color: dWhitePure,
                                fontSize: 14.0,
                              ),
                            ),
                            // Icon(
                            //   CupertinoIcons.paperplane_fill,
                            //   color: dWhitePure,
                            //   size: 20.0,
                            // ),
                          ),
                        ),
                        maxLines: 1,
                        placeholder: "painter",
                        placeholderStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontFamily: 'SFNSR',
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: Colors.blueAccent,
                        child: buttonStatus(_btnState, 'Update'),
                        onPressed: () async {
                          print(_myTags);
                          print(_toDelete);

                          setState(() {
                            _btnState = "loading";
                          });

                          for (var i = 0; i < _toDelete.length; i++) {
                            var status = await deleteWorkerTags(
                                _toDelete[i]['id'], token);

                            if (status == false) {
                              log("Failed to delete: ${_toDelete[i]['id']}");
                            }
                          }

                          var status = await uploadWorkerTags(_toAdd, token);

                          if (status == false) {
                            log("Failed to delete: $_toAdd");
                          }

                          await populateData();
                          await getInfo();

                          setState(() {
                            _btnState = "notloading";
                          });

                          Navigator.pop(context);

                          successModal(
                              context, "Worker tags updated successfully");
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
      },
    );
  }

  statusModal(context, token, isWorkr) {
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
                      "Account type",
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Change your account type",
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff8e8e90),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isWorkr = 1;
                        });

                        var data = {"isWorker": isWorkr};

                        await updateUserInfo(data);
                        await getInfo();

                        Navigator.pop(context);
                      },
                      child: StatusPill(
                        isWorker: isWorkr == 0 ? false : true,
                        tag: "Worker",
                        desc: "I help people out",
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isWorkr = 0;
                        });

                        var data = {"isWorker": isWorkr};

                        await updateUserInfo(data);
                        await getInfo();

                        Navigator.pop(context);
                      },
                      child: StatusPill(
                        isWorker: isWorkr == 0 ? false : true,
                        tag: "Client",
                        desc: "I am looking for people to help me out",
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

  editNameModal(context, token) {
    TextEditingController _fnameController = TextEditingController();
    TextEditingController _lnameController = TextEditingController();

    bool _errorStatus = false;
    String _errorMessage = "";
    String _btnState = 'notloading';

    showModalBottomSheet(
        backgroundColor: dBackgroundWhite,
        shape: const RoundedRectangleBorder(
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
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: const Color(0xff8e8e90).withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      "Edit Name",
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
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
                              "fname": _fnameController.text.toLowerCase(),
                              "lname": _lnameController.text.toLowerCase()
                            };

                            var updated = await updateUserInfo(data);

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
        shape: const RoundedRectangleBorder(
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
                        style: const TextStyle(
                          fontFamily: 'AR',
                          color: Color(0xff262626),
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        subtitle,
                        style: const TextStyle(
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

                                  var updated = await updateUserInfo(data);

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
                                if (_myController.text.isEmpty) {
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
                                    "email": _myController.text,
                                  };

                                  var updated = await updateUserInfo(data);

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

                              case "Location":
                                if (_myController.text.isEmpty) {
                                  return;
                                }

                                var data = {
                                  "location": _myController.text,
                                };

                                var updated = await updateUserInfo(data);

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
                                    return successModal(context,
                                        "Updated location successfully");
                                  });
                                  break;
                                }

                              case "Bio":
                                if (_myController.text.isEmpty) {
                                  return;
                                }

                                var data = {
                                  "bio": _myController.text,
                                };

                                var updated = await updateUserInfo(data);

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
                                    return successModal(
                                        context, "Updated bio successfully");
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

  calcType() {
    if (data.isEmpty) {
      return "-";
    } else {
      if (data[0]['isWorker'] == 0) {
        return "Client";
      } else {
        return "Worker";
      }
    }
  }

  calcWorkerService() {
    if (data.isEmpty) {
      return "-";
    } else {
      if (workerTags.isEmpty) {
        return "None";
      } else {
        return "${workerTags[0]['tag']}...";
      }
    }
  }

  calcClientService() {
    if (data.isEmpty) {
      return "-";
    } else {
      if (clientTags.isEmpty) {
        return "None";
      } else {
        return "${clientTags[0]['tag']}...";
      }
    }
  }

  _getTags(tags) async {
    var newTags = [];

    if (tags.length <= 0) {
      return newTags;
    } else {
      for (var i = 0; i < tags.length; i++) {
        newTags.add(tags[i]['tag']);
      }

      return newTags;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xffefefef),
          statusBarIconBrightness: Brightness.dark,
        ),
        // leadingWidth: 2.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.chevron_back),
            color: dBlack,
          ),
        ),
        backgroundColor: Color(0xffefefef),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Edit profile',
          style: TextStyle(
            fontFamily: 'AR',
            color: dBlack,
            fontSize: 20.0,
          ),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // TopControl(
            //   name: "Edit Profile",
            //   icon: CupertinoIcons.chevron_back,
            //   backgroundColor: Colors.transparent,
            // ),
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
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
                              image?.length != null
                                  ? Container(
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                      ),
                                      child: image == null
                                          ? Container()
                                          : Image.file(File(image!.path)),
                                    )
                                  : Container(
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            data.length == 0
                                                ? "https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjB3YWxsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
                                                : "$baseUrl/users/profileImage?imageCode=${data[0]['imageUrl']}",
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 20.0),
                              image != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // upload image to server and pop user
                                            // off of this page
                                            log("TOKEN: ${controller.user[0]['token']}");
                                            var status =
                                                await uploadImageRequest(
                                                    image!.path,
                                                    controller.user[0]
                                                        ['token']);
                                            log("STATUS: $status");

                                            // await updateUserInfo({
                                            //   "imageUrl": controller.user[0]
                                            //       ['prod_id'],
                                            // }, controller.user[0]['token']);
                                            await populateData();
                                            await getWorkers();
                                            await getAllUsers();
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                color: dBlueBackground
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: Icon(
                                              CupertinoIcons.check_mark,
                                              color: dBlueBackground,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              image = null;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: Icon(
                                              CupertinoIcons.xmark,
                                              color: Colors.red,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              image != null
                                  ? SizedBox(
                                      height: 20.0,
                                    )
                                  : Container(),
                              InkWell(
                                onTap: () async {
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                child: Text(
                                  "Change profile picture",
                                  style: TextStyle(
                                    fontFamily: 'SFNSR',
                                    fontSize: 16.0,
                                    color: dBlueBackground,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25.0),
                            ],
                          ),
                        ),
                      ),
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
                                value: data.isEmpty
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
                                value: data.isEmpty
                                    ? "-"
                                    : data[0]['email'].toLowerCase(),
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
                                value: data.isEmpty
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
                              },
                              child: InfoItem(
                                title: "Phone number",
                                value:
                                    data.isEmpty ? "-" : "+${data[0]['phone']}",
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await editModal(
                                  context,
                                  "Location",
                                  "Juja, Nairobi",
                                  "Change your location",
                                  4,
                                  "text",
                                  data[0]['token'],
                                );
                              },
                              child: InfoItem(
                                title: "Location",
                                value: data.isEmpty
                                    ? "-"
                                    : "${data[0]['location']}",
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await statusModal(
                                  context,
                                  data[0]['token'],
                                  data[0]['isWorker'],
                                );
                              },
                              child: InfoItem(
                                title: "Account type",
                                value: calcType(),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await _workerTagsModal(
                                  context,
                                  data[0]['token'],
                                  workerTags,
                                );
                              },
                              child: InfoItem(
                                title: "Services you offer",
                                value: calcWorkerService(),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                await _clientTagsModal(
                                  context,
                                  data[0]['token'],
                                  clientTags,
                                );
                              },
                              child: InfoItem(
                                title: "Services you are looking for",
                                value: calcClientService(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.0),
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
              const SizedBox(height: 5.0),
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
              ? const Icon(
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
