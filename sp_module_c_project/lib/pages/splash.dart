import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_module_c_project/controllers/app.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController controller;
  Animation? angle;

  startApp() async {
    if (window.locale.languageCode == 'en') {
      App.palavras = [
        'Record your summaries and save them here',
        'Change photo',
        'Select an option to change your photo',
        'Take photo',
        'Choose from gallery',
        'Edit Profile',
        'Settings',
        'Sign out',
        'Enter your access PIN',
        'Sign in',
        'Hello, Student!',
        'My summaries',
        'Profile',
        'Change font size',
        'Select an option to change the font size for this page',
        'Small',
        'Medium',
        'Large',
        'Article details',
        'Listen to article',
        'Start now',
        'Articles',
        'You can only play one summary at a time',
        'Summary deleted successfully',
        'Login successful',
        'Incorrect PIN',
        'All fields are required',
        'Allow brightness changes',
        'Home',
        'Summaries',
        'Profile',
        'Dark Theme',
        'High Contrast',
        'Language: English (automatic)',
        'Notifications',
      ];
    } else {
      App.palavras = [
        'Grave seus resumos e salve aqui',
        'Alterar foto',
        'Selecione uma opção para trocar sua foto',
        'Tirar foto',
        'Escolher da galeria',
        'Editar Perfil',
        'Configurações',
        'Sair',
        'Digite seu PIN de acesso',
        'Entrar',
        'Olá, Estudante!',
        'Meus resumos',
        'Perfil',
        'Alterar tamanho da fonte',
        'Selecione uma opção para trocar o tamanho da fonte dessa página.',
        'Pequeno',
        'Médio',
        'Grande',
        'Detalhes do artigo',
        'Ouvir artigo',
        'Começar agora',
        'Artigos',
        'Você só pode reproduzir um resumo por vez',
        'Resumo deletado com sucesso',
        'Login realizado com sucesso',
        'Pin incorreto',
        'Todos os campos são obrigatórios',
        'Permita alterar brilho',
        'Home',
        'Resumos',
        'Perfil',
        'Tema Escuro',
        'Alto Contraste',
        'Idioma: Português (automático)',
        'Notificações',
      ];
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? tempo = prefs.getInt('tempo');

    Future.delayed(Duration(seconds: tempo ?? 6), () async {
      await prefs.setInt('tempo', 3);
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });

    await animar(0.00, (6.28 / 4) * 1);
    await animar((6.28 / 4) * 1, (6.28 / 4) * 2);
    await animar((6.28 / 4) * 2, (6.28 / 4) * 3);
    await animar((6.28 / 4) * 3, (6.28 / 4) * 4);
  }

  animar(double begin, double end) async {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    angle = Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    await Future.delayed(const Duration(milliseconds: 300));
    controller.addListener(() => setState(() {}));
    await controller.forward();
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [Colors.grey[700]!, Colors.grey, Colors.white],
            transform: GradientRotation(angle?.value ?? 0),
          ),
        ),
        child: Center(child: Image.asset('assets/logo.png', height: 150)),
      ),
    );
  }
}
