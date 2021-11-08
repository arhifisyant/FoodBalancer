import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Tentang Aplikasi"),),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          alignment: Alignment.topCenter,
          child: const Text('''
        Aplikasi ini Dipersembahkan untuk Keluarga dalam rangka mengatur menu makanan dengan gizi seimbang. 
        \n \n -Arif Rahman Isyanto
        ''',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
        ),
        ),
    );
  } 
}