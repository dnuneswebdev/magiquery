import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'The favorties function is not available right now!',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'MAGIC',
          color: Theme.of(context).hintColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
