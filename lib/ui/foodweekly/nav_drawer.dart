import 'package:food_balancer/ui/foodcategory/food_category_page.dart';
import 'package:food_balancer/ui/pdfguide/pdf_guide_page.dart';
import 'package:food_balancer/ui/about/about_page.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green,
        //color: Color.fromRGBO(0, 105, 0, 1),
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Daftar Menu Seminggu',
                    icon: Icons.checklist,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Atur Makanan',
                    icon: Icons.food_bank_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Pedoman Gizi Seimbang',
                    icon: Icons.library_books,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Tentang Aplikasi',
                    icon: Icons.info_rounded,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white70),
                  //const SizedBox(height: 20),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Keluar Aplikasi',
                    icon: Icons.close,
                    onClicked: () => exit(0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));*/
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FoodCategoryPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PdfGuidePage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutPage(),
        ));
        break;
    }
  }
}
