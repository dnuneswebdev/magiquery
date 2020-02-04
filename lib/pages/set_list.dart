import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:magiquery/models/sets_model.dart';
import 'package:magiquery/services/magic_service.dart';

class SetListPage extends StatefulWidget {
  @override
  _SetListPageState createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  List<SingleSet> singleSet = new List<SingleSet>();
  List<SingleSet> filteredSingleSet = new List<SingleSet>();

  TextEditingController searchText = TextEditingController();

  final magicService = new MagicService();

  @override
  void initState() {
    super.initState();
    magicService.getSetList().then((setItem) {
      setState(() {
        singleSet = setItem;
        filteredSingleSet = singleSet;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchText,
          decoration: InputDecoration(
            labelText: ('Search Set / Block...'),
            suffixIcon: Icon(Icons.search),
            labelStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (text) {
            setState(() {
              filteredSingleSet = singleSet.where((setItem) {
                return setItem.name.toLowerCase().contains(text.toLowerCase());
              }).toList();
              // print(filteredSingleSet.length);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: filteredSingleSet.length,
        itemBuilder: (context, index) => _singleSetTile(context, index),
      ),
    );
  }

  Widget _singleSetTile(BuildContext context, int index) {
    final svgImg = filteredSingleSet[index].iconSvgUri;

    return InkWell(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: SvgPicture.network(
              svgImg,
              width: 30,
              height: 30,
              color: Colors.white,
              matchTextDirection: true,
            ),
            title: Text(
              filteredSingleSet[index].name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).hintColor,
            ),
          ),
          Divider(),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, 'set-detail',
            arguments: filteredSingleSet[index]);
      },
    );
  }
}
