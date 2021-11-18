import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Tentang Aplikasi"),),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        alignment: Alignment.topCenter,
        child: const Text('''
        Aplikasi ini dipersembahkan untuk keluarga dalam rangka mengatur variasi menu makanan dengan gizi seimbang. Mencakup variasi Makanan Pokok, Lauk, Sayur, dan Buah. 
        \n \n Arif Rahman Isyanto
        ''',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}