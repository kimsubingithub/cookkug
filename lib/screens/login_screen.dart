import 'package:cookkug/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'register_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final eController = TextEditingController();
  final pController = TextEditingController();

  final googleSign = GoogleSignIn();

  void signIn(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        var navigator = Navigator.of(context);
        bool result = await FirebaseService()
            .signInWithEmailAndPassword(email: email, password: password);
        if (result) {
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void googleSignIn(BuildContext context) async {
    var navigator = Navigator.of(context);
    bool result = await FirebaseService().signInWithGoogle();
    print(result);
    if (result) {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/2.png',
                      height: 200,
                      width: 400,
                    ),
                    //????????? ???????????????
                    Container(
                      margin: const EdgeInsets.fromLTRB(40, 70, 40, 0),
                      child: TextFormField(
                          controller: eController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            //????????? ?????? ??????
                            if (value!.isEmpty ||
                                !RegExp(r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return ("????????? ????????? ???????????????.");
                            }
                          },
                          textInputAction:
                              TextInputAction.next, //?????? ?????? ?????? ???????????? ??????
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "?????????",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: TextFormField(
                        autofocus:
                            false, //???????????? ????????? ????????? ???????????? ?????? ?????????. ???????????? false??????.
                        controller: pController,
                        obscureText: true, //??????????????? ....?????? ??????????????? ??????
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
                            hintText: "????????????",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    )
                  ],
                )),
            //????????? ??????
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 138, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(500, 50)),
                onPressed: () {
                  signIn(eController.text, pController.text, context);
                },
                child: const Text(
                  '???????????????',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //???????????? ????????? ?????? ??????
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextButton(
                child: const Text('??????????????????',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: const Text('SNS ???????????? ?????? ???????????????',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold))),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () => googleSignIn(context),
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Image(
                  image: AssetImage('assets/images/google.png'),
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
