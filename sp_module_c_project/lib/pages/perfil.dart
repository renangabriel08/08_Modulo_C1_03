import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/styles/styles.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List opcoes = [
    {'icon': Icons.dark_mode, 'txt': App.palavras[31], 'value': false},
    {'icon': Icons.contrast, 'txt': App.palavras[32], 'value': false},
    {'icon': Icons.language, 'txt': App.palavras[33], 'value': null},
    {'icon': Icons.notifications, 'txt': App.palavras[34], 'value': false},
  ];

  File? img;

  tirarFoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      img = File(image.path);
    }

    Navigator.pop(context);
    setState(() {});
  }

  modal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Cores.branco,
        title: Text(App.palavras[1], style: TextStyle(color: Cores.preto)),
        content: SingleChildScrollView(
          child: Text(App.palavras[2], style: TextStyle(color: Cores.preto)),
        ),
        actions: [
          TextButton(
            onPressed: () => tirarFoto(ImageSource.camera),
            child: Text(
              App.palavras[3],
              style: TextStyle(color: Cores.azulClaro),
            ),
          ),
          TextButton(
            onPressed: () => tirarFoto(ImageSource.gallery),
            child: Text(
              App.palavras[4],
              style: TextStyle(color: Cores.azulClaro),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    opcoes[0]['value'] = App.escuro;
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(999),
                      child: img != null
                          ? Image.file(img!, fit: BoxFit.cover)
                          : Image.asset(
                              'assets/perfil.jpeg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Cores.azulEscuro,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: IconButton(
                        onPressed: () => modal(),
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Renan Gabriel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Cores.preto,
              ),
            ),
            Text(
              'renan@gmail.com',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Cores.preto,
              ),
            ),
            Container(height: 16),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width * .5, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
                backgroundColor: Cores.azulEscuro,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text(
                App.palavras[5],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(height: 16),
            Row(
              children: [
                Text(
                  App.palavras[6],
                  style: TextStyle(
                    color: Cores.preto,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(height: 8),
            for (var opcao in opcoes)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Cores.preto, blurRadius: 5)],
                    color: Cores.branco,
                  ),
                  child: ListTile(
                    leading: Icon(opcao['icon'], color: Cores.preto),
                    title: Text(
                      opcao['txt'],
                      style: TextStyle(color: Cores.preto),
                    ),
                    trailing: opcao['value'] == null
                        ? Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Cores.preto,
                          )
                        : Switch(
                            value: opcao['value'],
                            onChanged: (value) {
                              opcao['value'] = !opcao['value'];

                              if (opcao['icon'] == Icons.dark_mode) {
                                App.escuro = opcao['value'];

                                if (App.escuro) {
                                  Cores.branco = Color(0xFF101010);
                                  Cores.preto = Color(0xFFFCFCFC);
                                } else {
                                  Cores.branco = Color(0xFFFCFCFC);
                                  Cores.preto = Color(0xFF101010);
                                }

                                App.page.value--;
                                App.page.value++;
                              }

                              setState(() {});
                            },
                          ),
                  ),
                ),
              ),

            Container(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
                backgroundColor: Cores.azulEscuro,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text(
                App.palavras[7],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
