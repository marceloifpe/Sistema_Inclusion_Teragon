import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtVideoPlayerPage extends StatefulWidget {
  final String yturl;
  const YtVideoPlayerPage({Key? key, required this.yturl}) : super(key: key);

  @override
  _YtVideoPlayerPageState createState() => _YtVideoPlayerPageState();
}

class _YtVideoPlayerPageState extends State<YtVideoPlayerPage> {
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.yturl);
    _ytController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Para garantir que o título e a imagem fiquem nas extremidades
          children: [
            const Text('Inclusion Teragon Player'),
            Image.asset(
              'imagens/player.png', // Caminho atualizado para a nova imagem
              height: 30, // Altura da imagem
              width: 30, // Largura da imagem
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue[600], // Cor da AppBar com contraste
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[200]!, // Azul claro
              Colors.indigo, // Indigo
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: YoutubePlayer(
            controller: _ytController,
            showVideoProgressIndicator: true,
            progressIndicatorColor:
                Colors.indigo, // Cor do indicador de progresso
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }
}
