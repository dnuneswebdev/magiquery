import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:magiquery/models/cards.model.dart';
import 'package:magiquery/models/sets_model.dart';
import 'package:magiquery/services/magic_service.dart';

class SetDetailPage extends StatelessWidget {
  final magicService = new MagicService();

  @override
  Widget build(BuildContext context) {
    final SingleSet singleSet = ModalRoute.of(context).settings.arguments;

    return FutureBuilder(
      future: magicService.getCardsBySet(singleSet.code),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Stack(
            children: <Widget>[
              _backgroundBlurImage(snapshot),
              Scaffold(
                body: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _cardDeck(context, snapshot),
                        SizedBox(height: 20),
                        Text(
                          singleSet.name,
                          style: TextStyle(
                            fontFamily: 'MAGIC',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).highlightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cards: ${singleSet.cardCount}',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Released: ${singleSet.releasedAt}',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
  Widget _cardDeck(
      BuildContext context, AsyncSnapshot<List<SingleCard>> snapshot) {
    return Swiper(
      layout: SwiperLayout.TINDER,
      itemCount: snapshot.data.length,
      itemHeight: 500,
      itemWidth: 500,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: FadeInImage(
            image: NetworkImage(snapshot.data[index].imageUris['border_crop']),
            placeholder: AssetImage('images/card-back-img.png'),
            // fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'card-detail',
                arguments: snapshot.data[index].id);
          },
        );
      },
    );
  }

  //BACKGROUND IMAGE
  Widget _backgroundBlurImage(AsyncSnapshot<List<SingleCard>> snapshot) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg-5.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
