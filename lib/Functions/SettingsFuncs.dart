import 'dart:developer';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/Dashboard/UserTab.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:domestics/widgets/settings/StatusPill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

//

feedbackModal(context, token) {
  TextEditingController _messageController = TextEditingController();

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
            builder: (BuildContext context, StateSetter setState) {
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
                  const Text(
                    'Feedback',
                    style: TextStyle(
                      fontFamily: 'AR',
                      color: Color(0xff262626),
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Talk to us about your thoughts and ideas on Domestics.',
                    style: TextStyle(
                      fontFamily: 'SFNSR',
                      color: Color(0xff8e8e90),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  InputWidget(
                    label: "Message",
                    placeholder: "Talk to us",
                    mycontroller: _messageController,
                    obscure: false,
                    lines: 4,
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

                        if (_messageController.text.length == 0) {
                          return setState(() {
                            _errorMessage = "You can't send an empty message.";
                            _errorStatus = true;
                            _buttonState = "notloading";
                          });
                        }

                        var status = await uploadFeedback(
                            token, _messageController.text);

                        if (status == false) {
                          return setState(() {
                            _errorMessage =
                                "Failed to add feedback. Try again later!";
                            _errorStatus = true;
                            _buttonState = "notloading";
                          });
                        } else {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                            return successModal(context, "Sent successfully");
                          });
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

// EditProfileModal(context) async {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _fnameController = TextEditingController();
//   TextEditingController _lnameController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmController = TextEditingController();

//   final _dbHelper = DatabaseHelper.instance;
//   var info = await _dbHelper.queryAllRows("userInfo");

//   showModalBottomSheet(
//     backgroundColor: dBackgroundWhite,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(15.0),
//       ),
//     ),
//     isScrollControlled: true,
//     context: context,
//     builder: (context) => FractionallySizedBox(
//       heightFactor: 0.9,
//       child: Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Stack(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 50.0,
//                     height: 4.0,
//                     margin: EdgeInsets.only(top: 10.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       color: const Color(0xff8e8e90).withOpacity(0.3),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40.0),
//               SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(height: 30.0),
//                     const Text(
//                       'Edit Profile',
//                       style: TextStyle(
//                         fontFamily: 'AR',
//                         color: Color(0xff262626),
//                         fontSize: 22.0,
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text(
//                       'Edit your credentials.',
//                       style: TextStyle(
//                         fontFamily: 'SFNSR',
//                         color: Color(0xff8e8e90),
//                         fontSize: 14.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15.0),
//                     InputWidget(
//                       label: "First Name",
//                       placeholder: "john",
//                       mycontroller: _fnameController,
//                       obscure: false,
//                     ),
//                     const SizedBox(height: 15.0),
//                     InputWidget(
//                       label: "Last Name",
//                       placeholder: "cena",
//                       mycontroller: _lnameController,
//                       obscure: false,
//                     ),
//                     const SizedBox(height: 15.0),
//                     InputWidget(
//                       label: "Email",
//                       placeholder: "johncena@gmail.com",
//                       mycontroller: _emailController,
//                       obscure: false,
//                     ),
//                     const SizedBox(height: 15.0),
//                     InputWidget(
//                       label: "Bio",
//                       placeholder: "I like pineapple pizza",
//                       mycontroller: _emailController,
//                       obscure: false,
//                     ),
//                     const SizedBox(height: 15.0),
//                     NumberInput(
//                       label: "Phone",
//                       focus: false,
//                       placeholder: "757690940",
//                       mycontroller: _phoneController,
//                       obscure: false,
//                     ),
//                     // const SizedBox(height: 10.0),
//                     // ErrorAlert(
//                     //   errorMessage: _errorMessage,
//                     //   status: _errorStatus,
//                     // ),
//                     const SizedBox(height: 20.0),
//                     Container(
//                       width: double.infinity,
//                       child: CupertinoButton(
//                         color: Colors.blueAccent,
//                         child: const Text(
//                           'Save Changes',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                             fontFamily: 'AR',
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 30.0),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

securityModal(context, token) {
  TextEditingController _confirmController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                const SizedBox(height: 18.0),
                const Text(
                  'Security',
                  style: TextStyle(
                    fontFamily: 'AR',
                    color: Color(0xff262626),
                    fontSize: 22.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Change your password.',
                  style: TextStyle(
                    fontFamily: 'SFNSR',
                    color: Color(0xff8e8e90),
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                InputWidget(
                  label: "Current password",
                  placeholder: "Current password",
                  mycontroller: _confirmController,
                  obscure: true,
                  lines: 1,
                ),
                const SizedBox(height: 20.0),
                InputWidget(
                  label: "New password",
                  placeholder: "New password",
                  mycontroller: _passwordController,
                  obscure: true,
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
                    child: buttonStatus(_buttonState, 'Update'),
                    onPressed: () async {
                      setState(() {
                        _buttonState = "loading";
                        _errorStatus = false;
                      });

                      if (_confirmController.text.length == 0 ||
                          _passwordController.text.length == 0) {
                        return setState(() {
                          _buttonState = "notloading";
                          _errorMessage = "Fill all fields";
                          _errorStatus = true;
                        });
                      }

                      if (_confirmController.text == _passwordController.text) {
                        return setState(() {
                          _buttonState = "notloading";
                          _errorMessage =
                              "You cannot change your password to the same password";
                          _errorStatus = true;
                        });
                      }

                      var data = {
                        "password": "${_passwordController.text}",
                      };

                      var updated = await updateUserInfo(data);

                      if (updated == false) {
                        return setState(() {
                          _buttonState = "notloading";
                          _errorMessage = "Update failed";
                          _errorStatus = true;
                        });
                      } else {
                        Future.delayed(const Duration(seconds: 2), () {
                          return Navigator.pop(context);
                        });
                      }
                      // Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        );
      });
    },
  );
}

statsModal(context) {
  showModalBottomSheet(
    backgroundColor: dBackgroundWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
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
            const SizedBox(height: 18.0),
            const Text(
              'Stats',
              style: TextStyle(
                fontFamily: 'AR',
                color: Color(0xff262626),
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Account engagement information.',
              style: TextStyle(
                fontFamily: 'SFNSR',
                color: Color(0xff8e8e90),
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Visits',
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff262626).withOpacity(0.5),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      '233',
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Profile Saves',
                      style: TextStyle(
                        fontFamily: 'SFNSR',
                        color: Color(0xff262626).withOpacity(0.5),
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      '6',
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: Color(0xff262626),
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    ),
  );
}

successModal(context, message) {
  showModalBottomSheet(
    backgroundColor: dBackgroundWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 30.0),
            Center(
              child: Icon(
                CupertinoIcons.hand_thumbsup_fill,
                color: dBlueBackground,
                size: 100.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              message,
              style: TextStyle(
                fontFamily: 'SFNSR',
                color: dBlack,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: CupertinoButton(
                color: const Color(0xff8e8e90).withOpacity(0.1),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: dBlueBackground,
                    fontSize: 16.0,
                    fontFamily: 'AR',
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    ),
  );
}

referredModal(context, refferals) {
  List clients = [
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Levin',
      'lname': "Adams",
      'minutesAway': '2 min away',
      'stars': 4,
      'bio':
          'Hello, i am a tutor in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1529390079861-591de354faf5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjB0ZWFjaGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Colleen',
      'lname': "Adams",
      'stars': 4,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am an IT support in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1617042375876-a13e36732a04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBwcm9ncmFtbWVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
  ];

  showModalBottomSheet(
    backgroundColor: dBackgroundWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
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
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Referred to me',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'AR',
                    color: Color(0xff262626),
                    fontSize: 22.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'People who have been reffered to you.',
                  style: TextStyle(
                    fontFamily: 'SFNSR',
                    color: Color(0xff8e8e90),
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          refferals.length == 0
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      // Icon(
                      //   CupertinoIcons.search,
                      //   size: 50.0,
                      //   color: dBlack,
                      // ),
                      // const SizedBox(height: 20.0),
                      Text(
                        'No refferals yet.',
                        style: TextStyle(
                          fontFamily: 'SFNSR',
                          color: Color(0xff8e8e90),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                )
              : Container(
                  height: 300.0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        for (var i in clients)
                          UserTab(
                            fname: i['fname'],
                            lname: i['lname'],
                            tags: i['tag'],
                            url: i['url'],
                            bio: i['bio'],
                            minutesAway: i['minutesAway'],
                            starsCount: 3,
                            reviews: [],
                            phone: i['phone'],
                            location: "Donholm",
                            userId: '56',
                          ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    ),
  );
}

reviewModal(context, userId) {
  final _usercontroller = Get.put(UserController());
  TextEditingController _myController = TextEditingController();

  bool _errorStatus = false;
  String _errorMessage = "";
  String _buttonState = 'notloading';
  double _ratingCount = 0;
  var token = _usercontroller.user[0]['token'];

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
                    userId == _usercontroller.user[0]['prod_id']
                        ? Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30.0),
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999.0),
                                    color: dGreyFaded,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.lock_fill,
                                    size: 60.0,
                                    color: dBlueBackground,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  "Hold it!",
                                  style: TextStyle(
                                    fontFamily: "AR",
                                    fontSize: 18.0,
                                    color: dBlueBackground,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "You cannot review yourself.",
                                  style: TextStyle(
                                    fontFamily: "SFNSR",
                                    fontSize: 16.0,
                                    color: dGrey,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  width: double.infinity,
                                  child: CupertinoButton(
                                    color: Colors.blueAccent,
                                    child: buttonStatus(
                                        _buttonState, 'Never mind'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 30.0),
                              Container(
                                child: Center(
                                  child: Text(
                                    "Select the stars to rate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "AR",
                                      fontSize: 12.0,
                                      color: dBlueBackground,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                child: Center(
                                  child: RatingBar.builder(
                                    unratedColor: Colors.grey.withOpacity(0.2),
                                    glow: false,
                                    initialRating: _ratingCount,
                                    ignoreGestures: false,
                                    allowHalfRating: false,
                                    itemSize: 50.0,
                                    itemCount: 5,
                                    updateOnDrag: true,
                                    itemBuilder: (context, _) => Icon(
                                      CupertinoIcons.star_fill,
                                      color: Color(0xff278fe9),
                                    ),
                                    onRatingUpdate: (rating) {
                                      log("$rating");
                                      setState(() {
                                        _ratingCount = rating;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              InputWidget(
                                label: "",
                                placeholder: "Add a comment",
                                mycontroller: _myController,
                                obscure: false,
                                lines: 3,
                              ),
                              const SizedBox(height: 20.0),
                              // SizedBox(height: _errorStatus == true ? 5.0 : 20.0),
                              // ErrorAlert(
                              //   errorMessage: _errorMessage,
                              //   status: _errorStatus,
                              // ),
                              Container(
                                width: double.infinity,
                                child: CupertinoButton(
                                  color: Colors.blueAccent,
                                  child: buttonStatus(_buttonState, 'Review'),
                                  onPressed: () async {
                                    setState(() {
                                      _buttonState = "loading";
                                      _errorStatus = false;
                                    });

                                    log("Rating $_ratingCount -- ${_myController.text}");
                                    var status = await uploadReview(
                                      userId,
                                      _myController.text,
                                      _ratingCount,
                                      token,
                                    );

                                    await populateData();
                                    await getWorkers();
                                    await getAllUsers();

                                    setState(() {
                                      _buttonState = "notloading";
                                      _errorStatus = false;
                                    });

                                    status == false
                                        ? Navigator.pop(context)
                                        : log("Failed");
                                  },
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            );
          },
        );
      });
}
