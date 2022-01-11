class Pokemon {
  final String name;
  final int number;
  final String imageURL;
  final String kind;

  Pokemon(this.name, this.number, this.imageURL, this.kind);

  Pokemon.fromJson(Map json)
      : name = json['name'],
        number = json["number"],
        imageURL = json["image_url"],
        kind = json["kind"];
}
