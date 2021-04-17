import 'package:flutter/material.dart';

import 'contacts_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Row(
            children: [
              _FeatureItem(
                'Contacts',
                Icons.contacts,
              ),
              _FeatureItem(
                'Transfer',
                Icons.monetization_on,
              ),
              _FeatureItem(
                'Transaction Feed',
                Icons.description,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String _name;
  final IconData _icon;

  _FeatureItem(this._name, this._icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ContactsList(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 95,
            width: 111,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  _icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  _name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
