import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:janthirak_mobile_dev/Model/Save_EmailAndPassword.dart';
import 'package:janthirak_mobile_dev/Pokemon_HomePage.dart';
import 'package:janthirak_mobile_dev/SignIn_page.dart';

class Register_page extends StatefulWidget {
  @override
  _Register_pageState createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {

  final _fromkey = GlobalKey<FormState>();
  Save_EmailAndPassword _saveEmailAndPassword = Save_EmailAndPassword();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
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
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                  onPressed: (){
                    Navigator.pop(context);
                  },),
                title:  Text('สมัครสมาชิก',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),

                centerTitle: true,
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14,bottom: 14),
                    child: Text("สมัครสมาชิก",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: () async{
                    if(_fromkey.currentState!.validate()){
                      _fromkey.currentState!.save(); //formkey save
                      try{
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _saveEmailAndPassword.email.toString(),
                            password: _saveEmailAndPassword.password.toString()
                        ).then((value){                               //.then จะทำงานก็ต่อเมื่อสร้างบช.ผู้ใช้เรียบร้อย แล้วให้เกิดอะไรขึ็นมา
                          _fromkey.currentState!.reset();
                          Fluttertoast.showToast(
                              msg: "สร้างบัญชีเรียบร้อยแล้ว",
                              gravity: ToastGravity.BOTTOM
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn_page())
                          );
                        });
                      }on FirebaseAuthException catch(e){
                        Fluttertoast.showToast(
                          msg: e.message.toString(),
                              gravity: ToastGravity.TOP
                        );
                      }
                    }
                    // bool pass =  _fromkey.currentState!.validate();
                    // if(pass){
                    //   if(UserController.text == User && PassController.text == Pass){
                    //     //เรียใช้ให้รีโหลดใหม่ หรือ เรียกใช้ eventIntitial
                    //     BlocProvider.of<ListDataPokemonBloc>(context).add(IntitialPokemonEvent());
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => Pokemon_HomePage())
                    //     );
                    //   }else{
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text("username or password incorrect!!",style: TextStyle(color: Colors.white),),
                    //           action: SnackBarAction(
                    //             label: "Undo",
                    //             onPressed: (){
                    //
                    //             },
                    //           ),
                    //         )
                    //     );
                    //   }
                    // }
                  },
                  // onPressed: ()  {
                  //   bool pass =  _fromkey.currentState!.validate();
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => SignIn_page())
                  //   );
                  //
                  // },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: Column(
                    children: [
                      Form(
                        key: _fromkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    // controller: UserController,
                                    // validator: (input){
                                    //   if(input!.isEmpty){
                                    //     return "กรุณากรอก Email";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      hintText: "ชื่อ-นามสกุล",
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.5)
                              ),
                              child:Column(
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
                                    // controller: PassController,
                                    // validator: (input){
                                    //   if(input!.isEmpty){
                                    //     return "กรุณากรอก Password";
                                    //   }
                                    //   return null;
                                    // },
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
                                    // controller: PassController,
                                    onSaved: (String? password){
                                      _saveEmailAndPassword.password = password;
                                    },
                                    // controller: PassController,
                                    // validator: (input){
                                    //   if(input!.isEmpty){
                                    //     return "กรุณากรอก Password";
                                    //   }
                                    //   return null;
                                    // },
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
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.5)
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    // controller: PassController,
                                    // validator: (input){
                                    //   if(input!.isEmpty){
                                    //     return "กรุณากรอก Password";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.black,fontSize: 16),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.only(left: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password ต้องประกอบไปด้วย :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
                            ),
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle_outline_outlined,color: Colors.lightGreen,),
                                    ],
                                  ),
                                  flex: 10,
                                ),

                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("จำนวนตัวอักขระรวมกันไม่น้อยกว่า 8 ตัว",style: TextStyle(fontSize: 14,color: Colors.lightGreen),
                                      ),
                                    ],
                                  ),
                                )


                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle_outline_outlined,color: Colors.black,),
                                    ],
                                  ),
                                  flex: 10,
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("ตัวอักษรพิมพ์ใหม่ (A-Z) อย่างน้อย 1 ตัว",style: TextStyle(fontSize: 14,color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle_outline_outlined,color: Colors.black,),
                                    ],
                                  ),
                                  flex: 10,
                                ),

                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("ตัวอักษรพิมพ์เล็ก (a-z) อย่างน้อย 1 ตัว",style: TextStyle(fontSize: 14,color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle_outline_outlined,color: Colors.black,),
                                    ],
                                  ),
                                  flex: 10,
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("ตัวเลข (0-9) อย่างน้อย 1 ตัว",style: TextStyle(fontSize: 14,color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
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
