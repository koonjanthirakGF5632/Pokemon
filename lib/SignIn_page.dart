import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:janthirak_mobile_dev/Model/Save_EmailAndPassword.dart';
import 'package:janthirak_mobile_dev/Model/Save_EmailAndPassword.dart';
import 'package:janthirak_mobile_dev/Pokemon_HomePage.dart';
import 'package:janthirak_mobile_dev/Register_page.dart';
import 'package:janthirak_mobile_dev/bloc/list_data_pokemon/list_data_pokemon_bloc.dart';
import 'package:janthirak_mobile_dev/bloc/list_data_pokemon/login_email_pass/login_email_pass_bloc.dart';

import 'Model/Save_EmailAndPassword.dart';

class SignIn_page extends StatefulWidget {
  @override
  _SignIn_pageState createState() => _SignIn_pageState();
}

class _SignIn_pageState extends State<SignIn_page> {

  final _fromkey = GlobalKey<FormState>();
  Save_EmailAndPassword _saveEmailAndPassword = Save_EmailAndPassword();
  // LoginEvent _saveEmailAndPasswordBlox = LoginEvent();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  LoginEmailPassBloc? _LoginBloc;
  Widget _widgetBox = SizedBox();

  @override
  void initState() {
    super.initState();

    print('111111111111111111');
  }


  @override
  Widget build(BuildContext context) {
    // _LoginBloc = BlocProvider.of<LoginEmailPassBloc>(context);
    return FutureBuilder(
      future: firebase,
        builder: (context,snapshot){
        if(snapshot.hasError){
          return Scaffold(
            appBar: AppBar(title: Text("Error",),),
            body: Center(child: Text("${snapshot.error}"),),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
              child: TextButton(
                  child: Text(
                      "สมัครสมาชิก".toUpperCase(),
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(color: Colors.deepOrange,width: 1.5)
                          )
                      )
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register_page())
                    );
                  }
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40,),
                      Form(
                        key: _fromkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20,right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: ("กรุณากรอก Email")),
                                      EmailValidator(errorText: ("รูปแบบ Email ไม่ถูกต้อง"))
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email){
                                      _saveEmailAndPassword.email = email;

                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.black,fontSize: 16),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.only(left: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: EdgeInsets.only(left: 20,right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.5)
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    validator: RequiredValidator(errorText: "กรุณากรอก Password"),
                                    obscureText: true,
                                    onSaved: (String? password){
                                      _saveEmailAndPassword.password = password;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.black,fontSize: 16),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.only(left: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              margin: EdgeInsets.only(left: 20,right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 14,bottom: 14),
                                          child: Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        onPressed: () async{
                                          if(_fromkey.currentState!.validate()){
                                            _fromkey.currentState!.save();
                                            // print(_saveEmailAndPassword.email);
                                            // print(_saveEmailAndPassword.password);
                                            try{
                                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                email: _saveEmailAndPassword.email.toString(),
                                                password: _saveEmailAndPassword.password.toString(),
                                              ).then((value){
                                                _fromkey.currentState!.reset();
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Pokemon_HomePage())
                                                );
                                              });
                                            }on FirebaseAuthException catch(e){
                                              Fluttertoast.showToast(
                                                  msg: e.message.toString(),
                                                  gravity: ToastGravity.CENTER
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.deepOrange,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 50,),
                      Text("หรือเข้าสู่ระบบด้วย",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15,),
                      Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 14,bottom: 14),
                                          child: Text("Facebook",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        // onPressed: ()  => _login,
                                        onPressed: () {

                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 14,bottom: 14),
                                          child: Text("Gmail",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                        // onPressed: () =>signInWithGoogle(),
                                        onPressed: ()  {
                                          bool pass =  _fromkey.currentState!.validate();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                )
            ),
            // body: BlocBuilder<LoginEmailPassBloc,LoginEmailPassState>(
            //   bloc: _LoginBloc,
            //   builder: (context,state){
            //     if (state is InitialLoginEmailPassState) {
            //       _LoginBloc!.add(IntitialLoginEvent());
            //
            //     }
            //     else if (state is LoginStateLoading) {
            //       _widgetBox = SingleChildScrollView(
            //           child: Container(
            //             margin: EdgeInsets.only(top: 50),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
            //                 ),
            //                 SizedBox(height: 40,),
            //                 Form(
            //                   key: _fromkey,
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: <Widget>[
            //                       Container(
            //                         margin: EdgeInsets.only(left: 20,right: 20),
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             border: Border.all(color: Colors.black,width: 1.5)
            //                         ),
            //                         child: Column(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             TextFormField(
            //                               validator: MultiValidator([
            //                                 RequiredValidator(errorText: ("กรุณากรอก Email")),
            //                                 EmailValidator(errorText: ("รูปแบบ Email ไม่ถูกต้อง"))
            //                               ]),
            //                               keyboardType: TextInputType.emailAddress,
            //                               onSaved: (String? email){
            //                                 _saveEmailAndPassword.email = email;
            //
            //                               },
            //                               decoration: InputDecoration(
            //                                 hintText: "Email",
            //                                 hintStyle: TextStyle(color: Colors.black,fontSize: 16),
            //                                 border: InputBorder.none,
            //                                 contentPadding:
            //                                 EdgeInsets.only(left: 15),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                       SizedBox(height: 20,),
            //                       Container(
            //                         margin: EdgeInsets.only(left: 20,right: 20),
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             border: Border.all(color: Colors.black,width: 1.5)
            //                         ),
            //                         child:Column(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             TextFormField(
            //                               validator: RequiredValidator(errorText: "กรุณากรอก Password"),
            //                               obscureText: true,
            //                               onSaved: (String? password){
            //                                 _saveEmailAndPassword.password = password;
            //                               },
            //                               decoration: InputDecoration(
            //                                 hintText: "Password",
            //                                 hintStyle: TextStyle(color: Colors.black,fontSize: 16),
            //                                 border: InputBorder.none,
            //                                 contentPadding:
            //                                 EdgeInsets.only(left: 15),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                       SizedBox(height: 40,),
            //                       Container(
            //                         margin: EdgeInsets.only(left: 20,right: 20),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Expanded(
            //                                 child: ElevatedButton(
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(top: 14,bottom: 14),
            //                                     child: Text("เข้าสู่ระบบ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            //                                   ),
            //                                   onPressed: () async{
            //                                     if(_fromkey.currentState!.validate()){
            //                                       _fromkey.currentState!.save();
            //                                       // print(_saveEmailAndPassword.email);
            //                                       // print(_saveEmailAndPassword.password);
            //                                       try{
            //                                         await FirebaseAuth.instance.signInWithEmailAndPassword(
            //                                           email: _saveEmailAndPassword.email.toString(),
            //                                           password: _saveEmailAndPassword.password.toString(),
            //                                         ).then((value){
            //                                           _fromkey.currentState!.reset();
            //                                           Navigator.pushReplacement(
            //                                               context,
            //                                               MaterialPageRoute(builder: (context) => Pokemon_HomePage())
            //                                           );
            //                                         });
            //                                       }on FirebaseAuthException catch(e){
            //                                         Fluttertoast.showToast(
            //                                             msg: e.message.toString(),
            //                                             gravity: ToastGravity.CENTER
            //                                         );
            //                                       }
            //                                     }
            //                                   },
            //                                   style: ElevatedButton.styleFrom(
            //                                     primary: Colors.deepOrange,
            //                                     onPrimary: Colors.white,
            //                                     shape: RoundedRectangleBorder(
            //                                       borderRadius: BorderRadius.circular(0),
            //                                     ),
            //                                   ),
            //                                 )
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //
            //                 SizedBox(height: 50,),
            //                 Text("หรือเข้าสู่ระบบด้วย",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),
            //                 ),
            //                 SizedBox(height: 15,),
            //                 Container(
            //                     margin: EdgeInsets.only(left: 20,right: 20),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Expanded(
            //                                 child: ElevatedButton(
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(top: 14,bottom: 14),
            //                                     child: Text("Facebook",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            //                                   ),
            //                                   // onPressed: ()  => _login,
            //                                   onPressed: () {
            //
            //                                   },
            //                                   style: ElevatedButton.styleFrom(
            //                                     primary: Colors.blue,
            //                                     onPrimary: Colors.white,
            //                                     shape: RoundedRectangleBorder(
            //                                       borderRadius: BorderRadius.circular(0),
            //                                     ),
            //                                   ),
            //                                 )
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(height: 10,),
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Expanded(
            //                                 child: ElevatedButton(
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(top: 14,bottom: 14),
            //                                     child: Text("Gmail",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            //                                   ),
            //                                   // onPressed: () =>signInWithGoogle(),
            //                                   onPressed: ()  {
            //                                     bool pass =  _fromkey.currentState!.validate();
            //                                   },
            //                                   style: ElevatedButton.styleFrom(
            //                                     primary: Colors.red,
            //                                     onPrimary: Colors.white,
            //                                     shape: RoundedRectangleBorder(
            //                                       borderRadius: BorderRadius.circular(0),
            //                                     ),
            //                                   ),
            //                                 )
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     )
            //                 ),
            //               ],
            //             ),
            //           )
            //       );
            //     }
            //     return _widgetBox;
            //   },
            // ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    });
  }
}
