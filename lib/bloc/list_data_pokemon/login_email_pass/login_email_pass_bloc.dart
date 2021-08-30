import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_email_pass_event.dart';

part 'login_email_pass_state.dart';

class LoginEmailPassBloc
    extends Bloc<LoginEmailPassEvent, LoginEmailPassState> {
  LoginEmailPassBloc() : super(InitialLoginEmailPassState());

  @override
  Stream<LoginEmailPassState> mapEventToState(
      LoginEmailPassEvent event) async* {
    if (event is IntitialLoginEvent) {
      yield LoginStateLoading();
    }
    else if (event is LoginEvent) {
      yield LoginStateLoading();
      await _LoginEmailPass();
      yield LoginStateCheckstatus();
    }
  }

  _LoginEmailPass() async{
    // try{
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _saveEmailAndPassword.email.toString(),
    //     password: _saveEmailAndPassword.password.toString(),
    //   ).then((value){
    //     _fromkey.currentState!.reset();
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => Pokemon_HomePage())
    //     );
    //   });
    // }on FirebaseAuthException catch(e){
    //   Fluttertoast.showToast(
    //       msg: e.message.toString(),
    //       gravity: ToastGravity.CENTER
    //   );
    // }
  }

}
