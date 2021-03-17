import 'package:flutter/material.dart';

class TileDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TileDetailsScreenState();
  }
}

class _TileDetailsScreenState extends State<TileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(
          '',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 1; i < 4; i++)
                  Text(
                    'Label $i',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
