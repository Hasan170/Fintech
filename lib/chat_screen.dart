import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:chatgpt/chatgpt.dart';

import 'package:velocity_x/velocity_x.dart';

import 'chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<ChatMessage> _messages = [];

  Gpt4ChatModel? _chatGPT;

  late OpenAI openAI;

  StreamSubscription? _subscription;

  @override
  void initState() {
    _chatGPT = Gpt4ChatModel();
    openAI = OpenAI.instance.build(
      token:
          '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', // Replace with your actual OpenAI API key
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
      enableLog: true,
    );
    super.initState();

    @override
    void dispose() {
      _subscription?.cancel();
      super.dispose();
    }
  }

  Future<void> _sendMessage() async {
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "User",
    );

    setState(() {
      _messages.insert(0, message);
    });

    _controller.clear();

    final request = ChatCompleteText(messages: [
      Messages(role: Role.assistant, content: 'Hello!'),
    ], maxToken: 200, model: Gpt4ChatModel());

    await openAI.onChatCompletion(request: request);

    final response = await openAI.onChatCompletion(request: request);

    final assistantMessage = ChatMessage(
      text: response?.choices.first.message.toString() ?? "",
      sender: "Assistant",
    );

    setState(() {
      _messages.insert(0, assistantMessage);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _controller,
          onSubmitted: (value) => _sendMessage(),
          decoration:
              const InputDecoration.collapsed(hintText: "Write a message"),
        )),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _sendMessage(),
        )
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI assiatant Demo")),
      body: SafeArea(
        child: Column(children: [
          Flexible(
              child: ListView.builder(
            reverse: true,
            padding: Vx.m8,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _messages[index];
            },
          )),
          Container(
            decoration: BoxDecoration(
              color: context.cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ]),
      ),
    );
  }
}
