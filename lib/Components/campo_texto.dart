import 'package:flutter/material.dart';
import 'package:flutter_app/Theme/app_padding.dart';

class CampoTexto extends StatefulWidget {
  final String titulo;
  final TextEditingController controller;
  const CampoTexto({super.key, this.titulo = '', required this.controller});
  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: TextField(
        decoration: InputDecoration(labelText: widget.titulo),
        controller: widget.controller,
      ),
    );
  }
}
