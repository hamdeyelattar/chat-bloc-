import 'package:bloc/bloc.dart';
import 'package:chat_app1/constants.dart';
import 'package:chat_app1/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatCubitInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

      
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {}
  }

  void getMassages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];

      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messagess: messagesList));
    });
  }
}
