import 'package:flutter/material.dart';
import 'package:flutter_app/Theme/app_padding.dart';

class Message {
  final String content;
  final bool isSent;
  final DateTime timeSent;

  Message({
    required this.content,
    required this.isSent,
    required this.timeSent,
  });
}

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final List<Message> sentMessages = [
    Message(
      content: 'Hello',
      isSent: true,
      timeSent: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  final List<Message> receivedMessages = [
    Message(
      content: 'Hi',
      isSent: false,
      timeSent: DateTime(2024, 10, 1),
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    List<Message> allMessages = [...sentMessages, ...receivedMessages];
    allMessages.sort((b, a) => a.timeSent.compareTo(b.timeSent));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Para que a lista role de baixo para cima
              itemCount: allMessages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = allMessages[index];
                return Align(
                  alignment: message.isSent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(AppPadding.small),
                    padding: const EdgeInsets.all(AppPadding.small),
                    decoration: BoxDecoration(
                      color: message.isSent
                          ? theme.primaryColor
                          : theme.secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(AppPadding.small),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(color: theme.primaryColorLight),
                        ),
                        Text(
                          _formatTime(message.timeSent),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.small),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Digite sua mensagem",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    sentMessages.add(
                      Message(
                        content: value,
                        isSent: true,
                        timeSent: DateTime.now(),
                      ),
                    );
                    _controller.clear(); // Limpa o campo após enviar
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Função para formatar a hora
  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
