import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/authentication/widgets/elevated_button.dart';
import 'package:import_chat_app/chat_box/blocs/chat_bloc.dart';
import 'package:import_chat_app/chat_box/styling/styling.dart';
import 'package:import_chat_app/constants/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {required this.loginUsername, required this.chatUserName, Key? key})
      : super(key: key);
  final String? loginUsername;
  final String? chatUserName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List chatList = [];
  List listMessage = [];
  late String tagId;

  @override
  void initState() {
    super.initState();
    createTag();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void createTag() {
    chatList.add(widget.loginUsername);
    chatList.add(widget.chatUserName);
    chatList.sort();
    var concatenate = StringBuffer();
    for (var item in chatList) {
      concatenate.write(item);
    }
    tagId = concatenate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(ChatInitial(tag: tagId)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            MyConstants.of(context)!.chatBoxAppbar,
            style: appBarTextStyle,
          ),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: state.values[index].username ==
                                  widget.loginUsername
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                              borderRadius: state.values[index].username ==
                                      widget.loginUsername
                                  ? borderCurrentUsername
                                  : borderGuestUsername,
                              elevation: 5.0,
                              color: state.values[index].username ==
                                      widget.loginUsername
                                  ? Colors.white
                                  : Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: SelectableText(
                                  state.values[index].data,
                                  style: TextStyle(
                                    color: state.values[index].username ==
                                            widget.loginUsername
                                        ? Colors.green
                                        : Colors.black,
                                    fontSize: labelChatText,
                                  ),
                                  cursorColor: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.blueAccent,
                  thickness: 2,
                ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return ListTile(
                      title: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            labelText: MyConstants.of(context)!.chatBoxHint),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () {
                          context.read<ChatBloc>().add(ChatPostValues(
                              tag: tagId,
                              data: _messageController.text,
                              username: widget.loginUsername));
                          _messageController.clear();
                        },
                        child: Text(MyConstants.of(context)!.chatSendMessage),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is ChatFailure) {
            return Center(
              child: ElevatedButtonField(
                  onTap: null, text: state.message.toString()),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
