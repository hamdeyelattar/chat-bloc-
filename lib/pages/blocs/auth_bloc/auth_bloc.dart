import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    //بنستخدمها في البلوك فقط 
    super.onTransition(transition);

    print(transition);
  }

}
void loginUser({required String email, required String password}) {}