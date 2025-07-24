import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/styles/styles.dart';

class Artigos extends StatefulWidget {
  const Artigos({super.key});

  @override
  State<Artigos> createState() => _ArtigosState();
}

class _ArtigosState extends State<Artigos> {
  int slide = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width,
              height: height * .25,
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height * .2,
                    child: CarouselSlider(
                      items: [
                        for (var artigo in App.artigos)
                          Container(
                            width: width,
                            height: height * .2,
                            decoration: BoxDecoration(
                              color: Cores.azulEscuro,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    artigo['titulo'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(width, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () => (),
                                    child: Text(
                                      App.palavras[20],
                                      style: TextStyle(
                                        color: Cores.azulEscuro,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                      options: CarouselOptions(
                        height: height * .3,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {
                          slide = index;
                          setState(() {});
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  Container(height: 8),
                  DotsIndicator(
                    dotsCount: App.artigos.length,
                    position: slide.toDouble(),
                    decorator: DotsDecorator(
                      color: Colors.grey,
                      activeColor: Cores.azulEscuro,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(height: 16),
            SizedBox(
              width: width,
              height: height * .48,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      App.palavras[21],
                      style: TextStyle(
                        fontSize: 20,
                        color: Cores.preto,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (var artigo in App.artigos)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: ListTile(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/detalhes',
                            (route) => false,
                          ),
                          title: Text(
                            artigo['titulo'],
                            style: TextStyle(color: Cores.preto),
                          ),
                          subtitle: Text(
                            artigo['descricao'],
                            style: TextStyle(color: Cores.preto),
                          ),
                          trailing: Text(
                            artigo['data'],
                            style: TextStyle(color: Cores.preto),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
