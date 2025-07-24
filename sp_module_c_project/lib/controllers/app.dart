import 'package:flutter/foundation.dart';

class App {
  static bool escuro = false;
  static Map artigo = {};
  static List artigos = [];
  static List resummos = [];
  static int ultimaPagina = 0;
  static ValueNotifier page = ValueNotifier<int>(0);

  static List palavras = [];
}
