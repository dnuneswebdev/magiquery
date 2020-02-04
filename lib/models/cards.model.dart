class Cards {
  List<SingleCard> items = new List();

  Cards();

  Cards.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final card = new SingleCard.fromJsonMap(item);
      items.add(card);
    }
  }
}

class SingleCard {
  String id;
  int mtgoId;
  int mtgoFoilId;
  String name;
  String lang;
  String releasedAt;
  String uri;
  String scryfallUri;
  String layout;
  bool highresImage;
  Map<String, dynamic> imageUris;
  String manaCost;
  double cmc;
  String typeLine;
  String oracleText;
  String power;
  String toughness;
  String setName;
  String rarity;

  SingleCard({
    this.id,
    this.mtgoId,
    this.mtgoFoilId,
    this.name,
    this.lang,
    this.releasedAt,
    this.uri,
    this.scryfallUri,
    this.layout,
    this.highresImage,
    this.imageUris,
    this.manaCost,
    this.cmc,
    this.typeLine,
    this.oracleText,
    this.power,
    this.toughness,
    this.setName,
    this.rarity,
  });

  SingleCard.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    mtgoId = json['mtgo_id'];
    mtgoFoilId = json['mtgo_foil_id'];
    name = json['name'];
    lang = json['lang'];
    releasedAt = json['released_at'];
    uri = json['uri'];
    scryfallUri = json['scryfall_uri'];
    layout = json['layout'];
    highresImage = json['highres_image'];
    imageUris = json['image_uris'];
    manaCost = json['mana_cost'];
    cmc = json['cmc'];
    typeLine = json['type_line'];
    oracleText = json['oracle_text'];
    power = json['power'];
    toughness = json['toughness'];
    setName = json['set_name'];
    rarity = json['rarity'];
  }
}
