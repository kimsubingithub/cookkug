import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookkug/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'mypage.dart';

class MyPageChange extends StatefulWidget {
  const MyPageChange({Key? key}) : super(key: key);

  @override
  State<MyPageChange> createState() => _MyPageChangeState();
}

class _MyPageChangeState extends State<MyPageChange> {
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseFirestore.instance
      .collection('user')
      .doc('${FirebaseAuth.instance.currentUser!.uid}');
  var nowUser = FirebaseAuth.instance.currentUser;

  void deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      _user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  void updateUser() {
    if (nameController.text != "") {
      _user.update({'name': nameController.text});
    }
  }

  void updatePassword() {
    if (password1Controller.text != "" && password2Controller.text != "") {
      final cred = EmailAuthProvider.credential(
          email: userE, password: passwordController.text);

      nowUser!.reauthenticateWithCredential(cred).then((value) {
        nowUser!
            .updatePassword(password1Controller.text)
            .then((_) {})
            .catchError((error) {});
      }).catchError((err) {});
    }
  }

  String userE = "";
  String userN = "";

  Future<String> getUser() async {
    var _docSnapshot = await _user.get();
    userE = _docSnapshot['email'];
    print(userE);
    userN = _docSnapshot['name'];
    print(userN);

    return userE;
  }

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Row(
                      children: const [
                        Text(
                          '??????',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.0,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                          child: Image(
                            image: AssetImage('assets/logo/text_logo.png'),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white, // ????????? ?????? ???
                    elevation: 0.0, // ?????? ?????????
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '??????????????????',
                            style: TextStyle(
                              color: Color.fromARGB(255, 116, 111, 111),
                              letterSpacing: 2.0,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              controller: nameController,
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'[a-zA-Z0-9]').hasMatch(value)) {
                                  return ("????????? ??? ?????? ???????????????.");
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: userN,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 255, 138, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: const Size(500, 50)),
                            onPressed: () {
                              if (nameController.text == "" &&
                                  addressController.text == "") {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false, // ??? ??? ????????? ??? ??????
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          '??????????????????',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 2.0,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const SingleChildScrollView(
                                          child: Text('??????????????? ??????????????????.'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              '??????',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 138, 0),
                                                  letterSpacing: 2.0,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                updateUser();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false, // ??? ??? ????????? ??? ??????
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          '??????????????????',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 2.0,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const SingleChildScrollView(
                                          child: Text('??????????????? ?????????????????????.'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              '??????',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 138, 0),
                                                  letterSpacing: 2.0,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text('????????????',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            '??????????????????',
                            style: TextStyle(
                              color: Color.fromARGB(255, 116, 111, 111),
                              letterSpacing: 2.0,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: userE,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (!regex.hasMatch(value!)) {
                                return ("?????? 6?????? ????????? ??????????????? ???????????????.");
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "?????? ????????????",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: password1Controller,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (!regex.hasMatch(value!)) {
                                return ("?????? 6?????? ????????? ??????????????? ???????????????.");
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "??? ????????????",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: password2Controller,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (!regex.hasMatch(value!)) {
                                return ("?????? 6?????? ????????? ??????????????? ???????????????.");
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "??? ???????????? ??????",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 255, 138, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: const Size(500, 50)),
                            onPressed: () async {
                              if (passwordController.text != "") {
                                try {
                                  UserCredential userCredential =
                                      await _auth.signInWithEmailAndPassword(
                                    email: userE,
                                    password: passwordController.text,
                                  );
                                  if (password1Controller.text == "" ||
                                      password2Controller.text == "") {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              '??????????????????',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                              child: Text('??? ??????????????? ??????????????????.'),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text(
                                                  '??????',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 138, 0),
                                                      letterSpacing: 2.0,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  } else if (password1Controller.text !=
                                      password2Controller.text) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              '??????????????????',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                              child: Text('??? ??????????????? ???????????? ????????????.'),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text(
                                                  '??????',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 138, 0),
                                                      letterSpacing: 2.0,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  } else {
                                    updatePassword();
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              '??????????????????',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                              child: Text('??????????????? ?????????????????????.'),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text(
                                                  '??????',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 138, 0),
                                                      letterSpacing: 2.0,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyPage()));
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'wrong-password') {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              '??????????????????',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                              child:
                                                  Text('?????? ??????????????? ???????????? ????????????.'),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text(
                                                  '??????',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 138, 0),
                                                      letterSpacing: 2.0,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          '??????????????????',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 2.0,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const SingleChildScrollView(
                                          child: Text('?????? ??????????????? ??????????????????.'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              '??????',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 138, 0),
                                                  letterSpacing: 2.0,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text('????????????',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2.0,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          '????????????',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 2.0,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const SingleChildScrollView(
                                          child: Text('????????? ?????????????????????????'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              '??????',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 138, 0),
                                                  letterSpacing: 2.0,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              deleteUser();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              '??????',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 2.0,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: const Text('????????????',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 116, 111, 111),
                                    letterSpacing: 2.0,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
