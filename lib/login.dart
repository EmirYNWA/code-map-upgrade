import 'package:code_map/forgot_password.dart';
import 'package:code_map/home_page.dart';
import 'package:code_map/service/auth.dart';
import 'package:code_map/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Ne postoji korisnik za unesenu email adresu",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins',),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Pogrešno unesena lozinka",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins',),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
            ),
            /*title: const Center(
              child: const Text(
                  'Code <map>',
                  style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  color: Colors.white,
                  fontSize: 30,
              ),
              ),
            ),*/
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite email adresu!';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf),
                              fontSize: 18.0,
                              fontFamily: 'Poppins-Medium',)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite lozinku';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Lozinka",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf),
                              fontSize: 18.0,
                              fontFamily: 'Poppins-Medium',)),
                   obscureText: true,   ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mailcontroller.text;
                            password=passwordcontroller.text;
                          });
                        }
                        userLogin();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.blue, Colors.green],
                                  ),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Text(
                            "Prijavite se",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins-Medium',),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
              },
              child: const Text("Zaboravili lozinku?",
                  style: TextStyle(
                      color: Color(0xFF8c8e98),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins-Medium',)),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "ili prijavite se preko",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins-Medium',),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Image.asset(
                    "assets/auth_icons/google.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                /*GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithApple();
                  },
                  child: Image.asset(
                    "assets/auth_icons/apple1.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )*/
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Nemate korisnički račun?",
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins-Medium',)),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const SignUp()));
                  },
                  child: const Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "Registrujte se",
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins-medium',),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
