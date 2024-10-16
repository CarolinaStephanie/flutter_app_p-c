import 'package:flutter/material.dart';
import 'package:flutter_app/Components/button.dart';
import 'package:flutter_app/Components/campo_texto.dart';
import 'package:flutter_app/Theme/app_padding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  String _textoSalvo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppPadding.large),
                  child: CampoTexto(
                    controller: _controller,
                    titulo: 'Digite o nome:',
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Button(label: 'Salvar', onPressedButton: _salvarDados),
                Button(label: 'Recuperar', onPressedButton: _recuperarDados),
                Button(label: 'Remover', onPressedButton: _removerDados),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.large),
                child: Text(_textoSalvo),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.large),
                child: Button(
                    label: 'Exemplo SQLite',
                    onPressedButton: () =>
                        {Navigator.pushNamed(context, '/sqlite')}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", _controller.text);
  }

  _recuperarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "sem valor";
    });
  }

  _removerDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
  }
}
