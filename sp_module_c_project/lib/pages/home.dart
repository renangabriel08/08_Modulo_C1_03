import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/pages/artigos.dart';
import 'package:sp_module_c_project/pages/perfil.dart';
import 'package:sp_module_c_project/pages/resumos.dart';
import 'package:sp_module_c_project/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  startApp() async {
    Permission.microphone.request();

    String jsonArtigos = await rootBundle.loadString('assets/artigos.json');
    String jsonArtigo = await rootBundle.loadString('assets/detalhes.json');

    App.artigo = jsonDecode(jsonArtigo);
    App.artigos = jsonDecode(jsonArtigos);

    setState(() {});
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ValueListenableBuilder(
      valueListenable: App.page,
      builder: (context, value, child) => Scaffold(
        backgroundColor: Cores.branco,
        appBar: AppBar(
          backgroundColor: Cores.branco,
          foregroundColor: Cores.preto,
          leading: value == 2
              ? IconButton(
                  onPressed: () => App.page.value = App.ultimaPagina,
                  icon: Icon(Icons.arrow_back),
                )
              : null,
          title: Text(
            value == 0
                ? App.palavras[10]
                : value == 1
                ? App.palavras[11]
                : App.palavras[12],
          ),
          actions: value == 0
              ? [
                  IconButton(
                    onPressed: () => (),
                    icon: Icon(Icons.notifications),
                  ),
                ]
              : [],
        ),
        body: App.artigos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : IndexedStack(
                index: App.page.value,
                children: [Artigos(), Resumos(), Perfil()],
              ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Cores.branco,
          unselectedItemColor: Cores.preto,
          selectedItemColor: Cores.azulClaro,
          currentIndex: App.page.value,
          onTap: (index) {
            App.ultimaPagina = value;
            App.page.value = index;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: App.palavras[28]),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note_outlined),
              label: App.palavras[29],
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: App.palavras[30]),
          ],
        ),
      ),
    );
  }
}
