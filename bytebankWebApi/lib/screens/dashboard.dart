import 'package:bytebankWebApi/screens/contacts_list.dart';
import 'package:bytebankWebApi/screens/transaction_list.dart';
import 'package:flutter/material.dart';

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
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _featureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => _showScreenTransfer(context),
                ),
                _featureItem(
                  'Transaction Feed',
                  Icons.transfer_within_a_station,
                  onClick: () => _showScreenTransferFeed(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showScreenTransfer(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ContactsList()
    ));
  }

  _showScreenTransferFeed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TransactionList()
    ));
  }
}

class _featureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _featureItem(this.name, this.icon, { @required this.onClick }): assert(icon != null), assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}