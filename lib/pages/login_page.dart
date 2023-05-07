import 'package:chat_app1/constants.dart';
import 'package:chat_app1/helper/show_snak_bar.dart';
import 'package:chat_app1/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app1/pages/chat_page.dart';

// import 'package:chat_app1/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app1/pages/register_page.dart';
import 'package:chat_app1/widgets/custom_button.dart';
import 'package:chat_app1/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String id = 'Login Page';
  String? email, password;
  bool isLoding = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoding = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoding = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoding = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoding,
        child: Scaffold(
          backgroundColor: kprimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  CustomFormTextFiled(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextFiled(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!));
                      } else {}
                    },
                    text: 'LOGIN',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account ?  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          '     REGISTER',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
