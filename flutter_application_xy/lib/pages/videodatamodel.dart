class VideoDataModel {
  int? id;
  String? title;
  String? videoUrl;
  String? image; // Novo campo para a imagem

  VideoDataModel(this.id, this.title, this.videoUrl,
      this.image); // Adicionando o novo campo no construtor

  VideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    image = json['image']; // Obter a imagem do JSON
  }
}
