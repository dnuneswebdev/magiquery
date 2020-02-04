import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:magiquery/models/cards.model.dart';
import 'package:magiquery/services/magic_service.dart';

class CardDetail extends StatelessWidget {
  final magicService = new MagicService();
  final String cardName;

  CardDetail({this.cardName});

  @override
  Widget build(BuildContext context) {
    final String cardId = ModalRoute.of(context).settings.arguments;

    Future<SingleCard> _refreshData() async {
      await Future.delayed(Duration(seconds: 2));
      return magicService.getSingleCard();
    }

    return FutureBuilder(
      future: cardName == null
          ? magicService.getSingleCard(cardId: cardId)
          : magicService.getSearchedCard(cardName),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Stack(
            children: <Widget>[
              _backgroundBlurImage(snapshot),
              Scaffold(
                body: Center(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FadeInImage(
                            image: NetworkImage(
                              snapshot.data.imageUris['border_crop'],
                            ),
                            placeholder: AssetImage(
                              'images/loading-card-5.gif',
                            ),
                          ),
                          SizedBox(height: 25),
                          _cardInfoTexts(context, snapshot),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
            ],
          );
        }
      },
    );
  }

  //WIDGETS
  //BACKGROUND IMAGE
  Widget _backgroundBlurImage(AsyncSnapshot snapshot) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(snapshot.data.imageUris['art_crop']),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }

  //CARD INFO TEXTS
  Widget _cardInfoTexts(BuildContext context, AsyncSnapshot snapshot) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              snapshot.data.name,
              style: TextStyle(
                fontFamily: 'MAGIC',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Type: ${snapshot.data.typeLine}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Rarity: ${snapshot.data.rarity}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Set: ${snapshot.data.setName}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Released: ${snapshot.data.releasedAt}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.star_border,
                  size: 40,
                  color: Colors.amberAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
