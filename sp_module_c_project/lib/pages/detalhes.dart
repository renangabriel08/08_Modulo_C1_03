import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/styles/styles.dart';
import 'package:sp_module_c_project/widgets/toast.dart';
import 'package:video_player/video_player.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  double brilho = 0;
  ValueNotifier fontSize = ValueNotifier<double>(16.0);

  late VideoPlayerController _controller;

  modal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ValueListenableBuilder(
        valueListenable: fontSize,
        builder: (context, value, child) => AlertDialog(
          backgroundColor: Cores.branco,
          title: Text(
            App.palavras[13],
            style: TextStyle(
              color: Cores.preto,
              fontSize: fontSize.value * 1.4,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              App.palavras[14],
              style: TextStyle(color: Cores.preto, fontSize: fontSize.value),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => fontSize.value = 14.0,
              child: Text(
                App.palavras[15],
                style: TextStyle(
                  color: Cores.azulClaro,
                  fontSize: fontSize.value,
                ),
              ),
            ),
            TextButton(
              onPressed: () => fontSize.value = 16.0,
              child: Text(
                App.palavras[16],
                style: TextStyle(
                  color: Cores.azulClaro,
                  fontSize: fontSize.value,
                ),
              ),
            ),
            TextButton(
              onPressed: () => fontSize.value = 20.0,
              child: Text(
                App.palavras[17],
                style: TextStyle(
                  color: Cores.azulClaro,
                  fontSize: fontSize.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startApp() async {
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    brilho = await ScreenBrightness.instance.system;

    setState(() {});
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return ValueListenableBuilder(
      valueListenable: fontSize,
      builder: (context, value, child) => Scaffold(
        backgroundColor: Cores.branco,
        appBar: AppBar(
          backgroundColor: Cores.branco,
          foregroundColor: Cores.preto,
          leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            ),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(App.palavras[18]),
          actions: [IconButton(onPressed: () => (), icon: Icon(Icons.share))],
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              App.artigo['titulo'],
                              style: TextStyle(
                                color: Cores.preto,
                                fontSize: fontSize.value * 1.7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(height: 4),
                        Row(
                          children: [
                            Text(
                              App.artigo['descricao'] +
                                  ' - ' +
                                  App.artigo['data'],
                              style: TextStyle(
                                color: Cores.preto,
                                fontSize: fontSize.value * 1.3,
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        SizedBox(
                          width: 400,
                          height: 200,
                          child: _controller.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : Container(),
                        ),
                        Container(height: 16),
                        Text(
                          App.artigo['conteudo'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Cores.preto,
                            fontSize: fontSize.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: 140,
                decoration: BoxDecoration(
                  color: Cores.branco,
                  boxShadow: [BoxShadow(color: Cores.preto, blurRadius: 5)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Cores.azulClaro,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: IconButton(
                                  onPressed: () => modal(),
                                  icon: Icon(
                                    Icons.text_fields,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Cores.azulClaro,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: IconButton(
                                  onPressed: () => (),
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * .5, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(5),
                              ),
                              backgroundColor: Cores.azulClaro,
                            ),
                            onPressed: () {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            },
                            icon: Icon(Icons.headphones, color: Colors.white),
                            label: Text(
                              App.palavras[19],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize.value,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.dark_mode, color: Cores.preto),
                          SizedBox(
                            width: width * .7,
                            child: Slider(
                              value: brilho,
                              onChanged: (value) {
                                brilho = value;
                                try {
                                  ScreenBrightness.instance
                                      .setSystemScreenBrightness(brilho);
                                } catch (e) {
                                  MyToast.get(App.palavras[27]);
                                }

                                setState(() {});
                              },
                            ),
                          ),
                          Icon(Icons.light_mode_outlined, color: Cores.preto),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
