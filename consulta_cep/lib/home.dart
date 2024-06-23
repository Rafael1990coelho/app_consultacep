import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  String resultado = "o endereço aparecera aqui!";
  TextEditingController txtcep = TextEditingController();

  void buscacep() async {
    //recuperar o cep
    String cep = txtcep.text;
    // definir a url
    String url = "https://viacep.com.br/ws/$cep/json/";
    // criar varial que armazena resposta

    http.Response response;
    //fazer a requisição utilizando o metodo get
    response = await http.get(Uri.parse(url)); //assicrona
    //requisição sicrona resposta rapida
    //requisição assicrona demora um tempo de resposta

    print("resposta: " + response.body);

    print("Status code: " + response.statusCode.toString());

    Map<String, dynamic> dados = json.decode(response.body);

    String logradouro = dados["logradouro"];
    String complemento = dados["complemento"];
    String bairro = dados["bairro"];
    String localidade = dados["localidade"];

    String endereco = "o endereço é: $logradouro, $complemento, $bairro, $localidade";

    setState(() {
      resultado = endereco;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("consulta de API"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(children: <Widget>[
          TextField(
            controller: txtcep,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite um cep ex 06730-000"),
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          ElevatedButton(
            child: Text("Consultar"),
            onPressed: buscacep,
          ),
          Text(resultado),
        ])),
      ),
    );
  }
}
