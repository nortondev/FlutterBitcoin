import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bitcoin extends StatefulWidget {

  const Bitcoin({super.key});
  @override
  State<Bitcoin> createState() => _BitcoinState();
}


class _BitcoinState extends State<Bitcoin> {
  String _preco = "0";

  void _recuperarPreco() async {
    
    var url = Uri.parse("https://blockchain.info/ticker");

    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Image.asset("imagens/bit.png"),
          SizedBox(height: 20,), // dar espaço entre a imagem e texto
          Text("R\$ $_preco" , style: const TextStyle(fontSize: 35),),

          TextButton(onPressed: (){_recuperarPreco();},
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
            child:const Text("Atualizar", style: TextStyle(fontSize: 20,color: Colors.white),) )
        ],)
        )
      ),
    );
  }
}