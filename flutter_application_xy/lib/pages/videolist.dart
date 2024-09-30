import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_xy/pages/videodatamodel.dart';
import 'package:flutter_application_xy/pages/ytVideoPlayerPage.dart';


class VideoList extends StatelessWidget {
  const VideoList({Key? key}) : super(key: key);

  Future<List<VideoDataModel>> readJson() async {
    final String response =
        await rootBundle.loadString('jsonFile/videolist.json');
    final List<dynamic> data = json.decode(response);
    return List<VideoDataModel>.from(
      data.map((e) => VideoDataModel.fromJson(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Vídeos'),
            Image.asset(
              'imagens/simbol.png', // Caminho da sua imagem
              height: 30,
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[200]!,
              Colors.indigo,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<VideoDataModel>>(
          future: readJson(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YtVideoPlayerPage(
                            yturl: items[index].videoUrl.toString(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].title.toString(),
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                                height: 10), // Espaço entre o título e a imagem
                            Image.asset(
                              items[index].image!, // Usando o campo de imagem
                              height:
                                  100, // Ajuste a altura conforme necessário
                              fit: BoxFit.cover, // Ajusta o modo de cobertura
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
