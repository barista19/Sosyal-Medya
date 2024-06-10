import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 350, // Yeni yükseklik
            decoration: BoxDecoration(
              color: Colors.indigo[700],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  languageProvider.isEnglish ? 'Menu' : 'Menü',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10), // Açıklığı ayarlamak için boşluk ekleyelim
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),

          ListTile(
            leading: Icon(Icons.home),
            title: Text(languageProvider.isEnglish ? 'Home Page' : 'Ana Sayfa'),
            onTap: () {
              Navigator.pop(context);
              context.go('/home');
            },
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(languageProvider.isEnglish ? 'My Friends' : 'Kişilerim'),
            onTap: () {
              Navigator.pop(context);
              context.go('/myfriends');
            },
          ),
          SizedBox(height: 10,),

          ListTile(
            leading: Icon(Icons.share),
            title: Text(languageProvider.isEnglish ? 'My Posts' : 'Paylaşımlarım'),
            onTap: () {
              Navigator.pop(context);
              context.go('/myposts');
            },
          ),
        ],
      ),
    );
  }
}
