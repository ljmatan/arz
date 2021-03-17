import 'dart:math';

import 'package:arz/logic/cache/prefs.dart';
import 'package:arz/ui/screens/home/add_menu_tile.dart';
import 'package:arz/ui/screens/home/slide_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List _tiles = [
    {
      'id': 100000 + Random().nextInt(900000),
      'lCode': 'RADIUS',
      'lValue': 4,
      'rCode': 'NONE',
      'rValue': 3,
    }
  ];

  void _addTile(Map newTile) => setState(() => _tiles.add(newTile));
  void _removeTile(int id) =>
      setState(() => _tiles.removeWhere((e) => e['id'] == id));
  void _updateTile(Map newData) {
    setState(() =>
        _tiles[_tiles.indexWhere((e) => e['id'] == newData['id'])] = newData);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, _) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            brightness: Brightness.dark,
            pinned: true,
            forceElevated: true,
            titleSpacing: 12,
            expandedHeight: MediaQuery.of(context).size.height / 3,
            title: Stack(
              children: [
                Text(
                  'ARZ',
                  style: TextStyle(
                    fontFamily: 'MuseoModerno',
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..color = Colors.white70
                      ..strokeWidth = 1.7,
                  ),
                ),
                Text(
                  'ARZ',
                  style: TextStyle(
                    fontFamily: 'MuseoModerno',
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 6,
            actions: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, right: 10),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              'CONTACT',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () {
                              // TODO: Push to contact page
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          final newTile = await showDialog(
                            context: context,
                            barrierColor: Colors.white70,
                            builder: (context) => AddTileDialog(),
                          );
                          if (newTile != null) _addTile(newTile);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    'https://picsum.photos/540/960',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 18, 40, 18),
                              child: DefaultTextStyle(
                                style: const TextStyle(color: Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'TOTAL HOURS',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '5 HRS',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              '20%',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'DIFF HOURS',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '1 HRS',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              '20%',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      body: SafeArea(
        child: ReorderableListView.builder(
          itemCount: _tiles.length,
          padding: const EdgeInsets.only(top: kToolbarHeight + 16, bottom: 16),
          onReorder: (oldIndex, newIndex) => setState(() {
            final old = _tiles[oldIndex];
            if (oldIndex > newIndex) {
              for (int i = oldIndex; i > newIndex; i--) {
                _tiles[i] = _tiles[i - 1];
              }
              _tiles[newIndex] = old;
            } else {
              for (int i = oldIndex; i < newIndex - 1; i++) {
                _tiles[i] = _tiles[i + 1];
              }
              _tiles[newIndex - 1] = old;
            }
          }),
          itemBuilder: (context, i) => ListTile(
            key: ValueKey(_tiles[i]['id']),
            tileColor: Colors.transparent,
            title: SlideTile(
              tileInfo: _tiles[i],
              removeTile: _removeTile,
              updateTile: _updateTile,
            ),
          ),
        ),
      ),
    );
  }
}
