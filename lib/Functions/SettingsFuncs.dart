import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/Dashboard/UserTab.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:domestics/widgets/Forms/NumberInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//

feedbackModal(context) {
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
            CupertinoTextField(
              padding: const EdgeInsets.all(20.0),
              placeholder: 'Type something',
              placeholderStyle: TextStyle(
                fontFamily: "SFNSR",
                color: dGrey,
              ),
              minLines: 4,
              maxLines: 4,
              decoration: BoxDecoration(
                color: const Color(0xff8e8e90).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: CupertinoButton(
                color: Colors.blueAccent,
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'AR',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    ),
  );
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
                ),
                const SizedBox(height: 20.0),
                InputWidget(
                  label: "New password",
                  placeholder: "New password",
                  mycontroller: _passwordController,
                  obscure: true,
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

                      var updated = await updateUserInfo(data, token);

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

successModal(context) {
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
                color: dBlack,
                size: 100.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Updated sucessfully",
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
      'fname': 'Levin Adams',
      'minutesAway': '2 min away',
      'stars': 4,
      'bio':
          'Hello, i am a tutor in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1529390079861-591de354faf5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjB0ZWFjaGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Lily Colt',
      'stars': 2,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a painter in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1510832842230-87253f48d74f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFpbnRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Sarah Payne',
      'stars': 1,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a baby sitter and pet sitter in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1534806391029-791d2695c38b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBiYWJ5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Brad Philips',
      'stars': 4,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a mechanic in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1583954964358-1bd7215b6f7a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Karl Gibson',
      'stars': 3,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a electrician in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': ['Thief', 'Preacher', 'Tutor', 'Teacher'],
      'fname': 'Colleen',
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
                            tags: i['tag'],
                            url: i['url'],
                            bio: i['bio'],
                            minutesAway: i['minutesAway'],
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
