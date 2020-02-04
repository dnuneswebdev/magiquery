import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:magiquery/services/magic_service.dart';

import 'card_detail.dart';

class Home extends StatelessWidget {
  final TextEditingController _cardSearchCtrl = TextEditingController();
  final magicService = new MagicService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: ('Search Card...'),
                    suffixIcon: Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: _cardSearchCtrl,
                ),
                suggestionsCallback: (textValue) async {
                  return await magicService.searchCard(textValue);
                },
                itemBuilder: (context, item) {
                  return ListTile(
                    title: Text(item),
                  );
                },
                onSuggestionSelected: (item) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetail(cardName: item),
                    ),
                  );
                  _cardSearchCtrl.clear();
                },
              ),
              Image(
                image: AssetImage('images/magic-logo-1.png'),
              ),
              Text(
                'MAGIQUERY',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'MAGIC',
                  letterSpacing: 5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'View Set/Block List',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'set-list');
                },
                color: Theme.of(context).accentColor,
              ),
              FlatButton(
                child: Text(
                  'Get a random card!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // textColor: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pushNamed(context, 'card-detail');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
