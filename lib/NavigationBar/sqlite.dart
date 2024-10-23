import 'package:flutter/material.dart';
import 'package:flutter_app/Components/button.dart';
import 'package:flutter_app/Components/campo_texto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteExample extends StatefulWidget {
  const SqliteExample({super.key});

  @override
  State<SqliteExample> createState() => _SqliteExampleState();
}

class _SqliteExampleState extends State<SqliteExample> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  _recuperarBancoDados() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "banco.db");

    var retorno = await openDatabase(localBD, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql = "CREATE TABLE IF NOT EXISTS usuarios("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nome VARCHAR, "
          "idade INTEGER)";
      db.execute(sql);
    });

    print("Aberto ${retorno.isOpen}");
    return retorno;
  }

  _salvarDados(String nome, int idade) async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {"nome": nome, "idade": idade};
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id");
    _nameController.clear();
    _ageController.clear();
  }

  _excluirBd() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "banco.db");
    await deleteDatabase(localBD);
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await bd.rawQuery(sql);
    for (var usuario in usuarios) {
      print(
          "id: ${usuario['id'].toString()} nome: ${usuario['nome']} idade: ${usuario['idade'].toString()}");
    }
  }

  _listarUsuarioPorId(int id) async {
    Database bd = await _recuperarBancoDados();

    String sql = "SELECT * FROM usuarios WHERE id = ?";

    List<Map<String, dynamic>> resultado = await bd.rawQuery(sql, [id]);

    if (resultado.isNotEmpty) {
      var usuario = resultado.first;
      print("id: ${usuario['id'].toString()} "
          "nome: ${usuario['nome']} "
          "idade: ${usuario['idade'].toString()}");
    } else {
      print("Usuário com id $id não encontrado");
    }
  }

  @override
  Widget build(BuildContext context) {
    _recuperarBancoDados();
    return Scaffold(
        appBar: AppBar(
          title: Text('Banco de Dados'),
        ),
        body: Column(
          children: [
            CampoTexto(titulo: 'Digite o nome:', controller: _nameController),
            CampoTexto(titulo: 'Digite a idade:', controller: _ageController),
            Button(
                label: 'Salvar um usuário',
                onPressedButton: () => _salvarDados(
                    _nameController.text, int.parse(_ageController.text))),
            Button(
                label: 'Listar todos usuários',
                onPressedButton: _listarUsuarios),
            Button(
                label: 'Listar um usuário',
                onPressedButton: () => _listarUsuarioPorId(1)),
            Button(label: 'Atualizar um usuário', onPressedButton: () => {}),
            Button(label: 'Excluir um usuário', onPressedButton: () => {}),
            Button(label: 'Excluir bd', onPressedButton: _excluirBd),
          ],
        ));
  }
}
