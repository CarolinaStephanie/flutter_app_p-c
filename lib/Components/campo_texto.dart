import 'package:flutter/material.dart';
import 'package:flutter_app/Theme/app_padding.dart';

class CampoTexto extends StatefulWidget {
  final String titulo;
  const CampoTexto({super.key, this.titulo = ''});
  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.medium),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.medium),
          child: TextField(
            style: TextStyle(fontSize: theme.textTheme.bodySmall?.fontSize),
            decoration: InputDecoration(
              labelText: widget.titulo,
            ),
            maxLength: 10,
            enabled: true,
            keyboardType: TextInputType.text,
            onChanged: (value) => {print(value)},
            controller: _textEditingController,
            obscureText: true,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              print(_textEditingController.text);
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
