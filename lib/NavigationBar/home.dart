import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.symmetric(vertical: AppPadding.large),
                child: TextField(
                  decoration:
                      const InputDecoration(labelText: 'Digite o nome:'),
                  controller: _controller,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  onPressed: _salvarDados,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Borda quadrada
                    ),
                  ),
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _recuperarDados,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Borda quadrada
                    ),
                  ),
                  child: const Text('Recuperar'),
                ),
                ElevatedButton(
                  onPressed: _removerDados,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Borda quadrada
                    ),
                  ),
                  child: const Text('Remover'),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.large),
                child: Text(_textoSalvo),
              )
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
