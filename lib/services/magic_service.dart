import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:magiquery/models/cards.model.dart';
import 'package:magiquery/models/sets_model.dart';

class MagicService {
  String _url = 'https://api.scryfall.com';

  bool isLoading = false;

  //METHODS
  //GET A SINGLE CARD
  Future<SingleCard> getSingleCard({String cardId}) async {
    if (cardId != null) {
      return _buildResponse(_url + '/cards/$cardId');
    } else {
      return _buildResponse(_url + '/cards/random');
    }
  }

  //GET SEARCHED NAMED CARD
  Future<SingleCard> getSearchedCard(String cardName) async {
    final exactCardName = cardName.toLowerCase();
    return _buildResponse(_url + '/cards/named?exact=$exactCardName');
  }

  //GET ALL THE SETS
  Future<List<SingleSet>> getSetList() async {
    final response = await http.get(_url + '/sets');
    final decodedData = json.decode(response.body);
    final setList = new SetList.fromJsonList(decodedData['data']);

    return setList.items;
  }

  //GET A SINGLE SET WITH CARDS
  Future<List<SingleCard>> getCardsBySet(String setCode) async {
    final response = await http.get(_url + '/cards/search?q=set%3A$setCode');
    final decodedData = json.decode(response.body);
    final cards = new Cards.fromJsonList(decodedData['data']);

    return cards.items;
  }

  //SEARCH CARD AUTOCOMPLETE
  Future<List> searchCard(String cardText) async {
    final response = await http.get(_url + '/cards/autocomplete?q=$cardText');
    final decodedData = json.decode(response.body);

    return decodedData['data'];
  }

  //PROCESS SIMILAR CARD RESPONSE
  Future<SingleCard> _buildResponse(itemUrl) async {
    final response = await http.get(itemUrl);
    final decodedData = json.decode(response.body);
    final card = new SingleCard.fromJsonMap(decodedData);

    return card;
  }
}
