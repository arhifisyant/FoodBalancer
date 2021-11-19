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
        Aplikasi ini dipersembahkan bagi keluarga, khususnya ibu rumah tangga untuk membantu mengatur menu makanan yang beraneka ragam dalam satu minggu. Keanekaragaman makanan ini mencakup variasi makanan dari kelompok makanan pokok, lauk, sayur, dan buah. 
        \n \n Arif Rahman Isyanto
        ''',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}