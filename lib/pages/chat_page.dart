import 'package:chat_app1/constants.dart';
import 'package:chat_app1/model/message_model.dart';
import 'package:chat_app1/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app1/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  
  static String id = 'ChatPage';
  List<Message> messagesList = [];
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 60,
            ),
            Text('Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if(state is ChatSuccess){
                  messagesList = state.messagess;
                }
              },
              builder: (context, state) {
                
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: 'email', );
                controller.clear();
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(seconds: 1),
                );
              },
              decoration: InputDecoration(
                hintText: 'send message',
                suffixIcon: Icon(
                  Icons.send,
                  color: kprimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kprimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
