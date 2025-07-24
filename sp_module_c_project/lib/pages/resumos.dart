import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/styles/styles.dart';
import 'package:sp_module_c_project/widgets/toast.dart';

class Resumos extends StatefulWidget {
  const Resumos({super.key});

  @override
  State<Resumos> createState() => _ResumosState();
}

class _ResumosState extends State<Resumos> {
  Timer? timer;
  int segundos = 0;

  FlutterSoundPlayer player = FlutterSoundPlayer();
  FlutterSoundRecorder recorder = FlutterSoundRecorder();

  reproduzir(resumo) async {
    if (player.isPlaying && resumo['play']) {
      resumo['play'] = false;
      await player.stopPlayer();
    } else if (player.isPlaying && !resumo['play']) {
      MyToast.get(App.palavras[22]);
    } else {
      resumo['play'] = true;
      setState(() {});
      await player.startPlayer(
        codec: Codec.aacMP4,
        fromURI: resumo['path'],
        whenFinished: () {
          resumo['play'] = false;
          setState(() {});
        },
      );
    }

    setState(() {});
  }

  gravar() async {
    if (recorder.isRecording) {
      String path = await recorder.stopRecorder() ?? '';

      App.resummos.insert(0, {'path': path, 'titulo': path, 'play': false});

      timer?.cancel();
      setState(() {});
    } else {
      segundos = 0;
      setState(() {});

      await recorder.startRecorder(
        codec: Codec.aacMP4,
        toFile: '${DateTime.now().millisecondsSinceEpoch}.aac',
      );

      timer = Timer.periodic(const Duration(seconds: 1), (_) async {
        if (recorder.isRecording) {
          segundos++;

          if (segundos == 60) {
            String path = await recorder.stopRecorder() ?? '';

            App.resummos.insert(0, {
              'path': path,
              'titulo': path,
              'play': false,
            });

            timer?.cancel();
          }

          setState(() {});
        }
      });

      setState(() {});
    }
  }

  startApp() async {
    await recorder.openRecorder();
    await player.openPlayer();

    setState(() {});
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.branco,
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: App.resummos.isEmpty
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: segundos / 60,
                minHeight: 10,
                borderRadius: BorderRadius.circular(999),
              ),
              Container(height: 16),
              if (App.resummos.isEmpty)
                Text(
                  App.palavras[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Cores.preto, fontSize: 20),
                )
              else
                for (var resumo in App.resummos)
                  ListTile(
                    title: Text(
                      resumo['titulo'].toString().substring(
                        resumo['titulo'].toString().lastIndexOf('/') + 1,
                        resumo['titulo'].toString().lastIndexOf('.'),
                      ),
                      style: TextStyle(color: Cores.preto, fontSize: 16),
                    ),
                    subtitle: Text(
                      window.locale.languageCode == 'en'
                          ? 'Description'
                          : 'Descrição ' +
                                resumo['titulo'].toString().substring(
                                  resumo['titulo'].toString().lastIndexOf('/') +
                                      1,
                                  resumo['titulo'].toString().lastIndexOf('.'),
                                ),
                      style: TextStyle(color: Cores.preto, fontSize: 16),
                    ),
                    leading: IconButton(
                      onPressed: () => reproduzir(resumo),
                      icon: Icon(
                        !resumo['play'] ? Icons.play_arrow : Icons.stop,
                        color: Cores.preto,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        App.resummos.remove(resumo);
                        setState(() {});
                        MyToast.get(App.palavras[23]);
                      },
                      icon: Icon(Icons.delete, color: Cores.preto),
                    ),
                  ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Cores.azulClaro,
        onPressed: () => gravar(),
        child: Icon(
          Icons.mic,
          color: recorder.isRecording ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
