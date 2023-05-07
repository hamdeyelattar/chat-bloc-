import 'package:chat_app1/constants.dart';
import 'package:chat_app1/helper/show_snak_bar.dart';
import 'package:chat_app1/pages/chat_page.dart';
import 'package:chat_app1/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app1/widgets/custom_button.dart';
import 'package:chat_app1/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = 'registerPage';
  String? password;

  bool isLoding = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoding = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoding = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMessage);
          isLoding = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
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
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .registerUser(email: email!, password: password!);
                        } else {}
                      },
                      text: 'REGISTER',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account ?  ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '     Login',
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
        );
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
