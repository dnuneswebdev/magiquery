class SetList {
  List<SingleSet> items = new List();

  SetList();

  SetList.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final card = new SingleSet.fromJsonMap(item);
      items.add(card);
    }
  }
}

class SingleSet {
  String object;
  String id;
  String code;
  String mtgoCode;
  String arenaCode;
  int tcgplayerId;
  String name;
  String uri;
  String scryfallUri;
  String searchUri;
  String releasedAt;
  String setType;
  int cardCount;
  bool digital;
  bool foilOnly;
  String blockCode;
  String block;
  String iconSvgUri;

  SingleSet({
    this.object,
    this.id,
    this.code,
    this.mtgoCode,
    this.arenaCode,
    this.tcgplayerId,
    this.name,
    this.uri,
    this.scryfallUri,
    this.searchUri,
    this.releasedAt,
    this.setType,
    this.cardCount,
    this.digital,
    this.foilOnly,
    this.blockCode,
    this.block,
    this.iconSvgUri,
  });

  SingleSet.fromJsonMap(Map<String, dynamic> json) {
    object = json['object'];
    id = json['id'];
    code = json['code'];
    mtgoCode = json['mtgo_code'];
    arenaCode = json['arena_code'];
    tcgplayerId = json['tcgplayer_id'];
    name = json['name'];
    uri = json['uri'];
    scryfallUri = json['scryfall_uri'];
    searchUri = json['search_uri'];
    releasedAt = json['released_at'];
    setType = json['set_type'];
    cardCount = json['card_count'];
    digital = json['digital'];
    foilOnly = json['foil_only'];
    blockCode = json['block_code'];
    block = json['block'];
    iconSvgUri = json['icon_svg_uri'];
  }
}
