import 'dart:async';

import 'package:customer/Application/message/message_cubit.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Presentation/Common/own.dart';
import 'package:customer/Presentation/Common/reply.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final int id;
  final int userType;
  final String name;
  String? email;
  ChatPage({
    super.key,
    required this.id,
    required this.name,
    this.email,
    required this.userType,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ValueNotifier<bool> isEmojiPickerVisible = ValueNotifier(false);
  final ValueNotifier<FocusNode> focusNodeNotifier = ValueNotifier(FocusNode());
  final TextEditingController textEditingController = TextEditingController();
  Timer? _timer;
  bool _isInitialLoad = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageCubit>(
      context,
    ).viewMessages(widget.id, widget.userType, widget.email ?? '');
    focusNodeNotifier.value.addListener(() {
      if (focusNodeNotifier.value.hasFocus) {
        isEmojiPickerVisible.value = false;
      }
    });

    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      BlocProvider.of<MessageCubit>(
        context,
      ).viewMessages(widget.id, widget.userType, widget.email ?? '');
    });
  }

  @override
  void dispose() {
    // Dispose of the timer
    _timer?.cancel();
    focusNodeNotifier.value.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(parsedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 166, 233, 237),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: size * 0.045,
              child: Center(
                child: Text(
                  getFirstLetter(widget.name),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              getName(widget.name),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessageCubit, MessageState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.isFailureOrSuccessForViewMessage.fold(
                  () {
                    if (_isInitialLoad) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return state.chats!.isEmpty || state.chats == null
                          ? Center(
                            child: Text(
                              'No Messages',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: state.chats!.length,
                            itemBuilder: (context, index) {
                              final message =
                                  state.chats![state.chats!.length - 1 - index];
                              return message.direction == 2
                                  ? OwnMessageCard(
                                    message: message.message!,
                                    time: formatDateTime(message.timestamp!),
                                  )
                                  : ReplyCard(
                                    message: message.message!,
                                    time: formatDateTime(message.timestamp!),
                                  );
                            },
                          );
                    }
                  },
                  (either) {
                    _isInitialLoad = false;
                    return either.fold(
                      (l) {
                        return const Center(child: Text('Error'));
                      },
                      (r) {
                        return r.isEmpty
                            ? Center(
                              child: Text(
                                'No Messages',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            : Column(
                              children: [
                                SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: r.length,
                                    itemBuilder: (context, index) {
                                      final message = r[r.length - 1 - index];
                                      return message.direction == 2
                                          ? OwnMessageCard(
                                            message: message.message!,
                                            time: formatDateTime(
                                              message.timestamp!,
                                            ),
                                          )
                                          : ReplyCard(
                                            message: message.message!,
                                            time: formatDateTime(
                                              message.timestamp!,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                              ],
                            );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChatInputWidget(
                onEmojiPressed: () {
                  if (!isEmojiPickerVisible.value) {
                    focusNodeNotifier.value.unfocus();
                    focusNodeNotifier.value.canRequestFocus = true;
                  }
                  isEmojiPickerVisible.value = !isEmojiPickerVisible.value;
                },
                focusNodeNotifier: focusNodeNotifier,
                textEditingController: textEditingController,
                onPressed: () {
                  final staff = TokenManager.instance.stafftype;
                  if (staff == '1') {
                    BlocProvider.of<MessageCubit>(context).sendMessage(
                      widget.id,
                      textEditingController.text,
                      widget.email,
                    );
                  } else {
                    BlocProvider.of<MessageCubit>(
                      context,
                    ).sendMessage(widget.id, textEditingController.text, '');
                  }
                  textEditingController.clear();
                },
              ),
              ValueListenableBuilder(
                valueListenable: isEmojiPickerVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? emojiSelect(textEditingController)
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatInputWidget extends StatelessWidget {
  final VoidCallback onEmojiPressed;
  final VoidCallback onPressed;
  final ValueNotifier<FocusNode> focusNodeNotifier;
  final TextEditingController textEditingController;
  const ChatInputWidget({
    required this.onEmojiPressed,
    required this.focusNodeNotifier,
    super.key,
    required this.textEditingController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.02;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.4,
        vertical: size * 0.4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blueAccent,
                      ),
                      onPressed: onEmojiPressed,
                    ),
                    Expanded(
                      child: ValueListenableBuilder<FocusNode>(
                        valueListenable: focusNodeNotifier,
                        builder: (context, focusNode, child) {
                          return TextField(
                            focusNode: focusNode,
                            keyboardType: TextInputType.multiline,
                            controller: textEditingController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
            color: Colors.green,
            onPressed: onPressed,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 5,
              left: 10,
            ),
            shape: const CircleBorder(),
            minWidth: 0,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}

Widget emojiSelect(TextEditingController textEditingController) {
  return EmojiPicker(
    onEmojiSelected: (category, emoji) {
      textEditingController.text = textEditingController.text + emoji.emoji;
    },
    config: const Config(
      height: 256,
      checkPlatformCompatibility: true,
      emojiViewConfig: EmojiViewConfig(
        emojiSizeMax: 28,
        columns: 7,
        horizontalSpacing: 0,
        verticalSpacing: 0,
        backgroundColor: Colors.white,
      ),
    ),
  );
}

String getName(String email) {
  final namePart = email.split('@').first;
  if (namePart.isNotEmpty) {
    return namePart.toUpperCase();
  }
  return "NA"; // Default value if email is invalid
}

String getFirstLetter(String email) {
  final namePart = email.split('@').first;
  if (namePart.isNotEmpty) {
    return namePart[0].toUpperCase();
  }
  return "N"; // Default value if email is invalid
}
