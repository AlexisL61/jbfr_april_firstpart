class GameFile {
  final String id;
  final String name;
  final String url;
  final String type;

  GameFile({required this.id, required this.name, required this.url, required this.type});

  factory GameFile.fromJson(Map<String, dynamic> json) {
    return GameFile(id: json["\$id"], name: json['name'], url: json['url'], type: json['type']);
  }
}
