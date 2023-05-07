import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user not found') {
        emit(LoginFailure(errorMessage: 'User Not Found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'User Not Found'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'something went wrong'));
    }
  }
  

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak-password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email-already-in-use'));
      }
    } catch (ex) {
      emit(RegisterFailure(errorMessage: 'there was an error'));
    }
  }
}
