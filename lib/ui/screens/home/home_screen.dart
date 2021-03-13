import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[1],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ARZ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => showDialog(
                          context: context,
                          barrierColor: Colors.white70,
                          builder: (context) => Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Material(
                                elevation: 16,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Image.network(
                'https://picsum.photos/540/960',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                bottomLeft: Radius.circular(24),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 18),
                                  child: Text(
                                    'CONTACT',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                          child: DefaultTextStyle(
                            style: const TextStyle(color: Colors.white),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
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
                                    width: MediaQuery.of(context).size.width,
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
          const Divider(height: 0, thickness: 2),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: 6,
              padding: EdgeInsets.zero,
              onReorder: (oldIndex, newIndex) {},
              itemBuilder: (context, i) => ListTile(
                key: ValueKey(Random().nextInt(100)),
                tileColor: Colors.transparent,
                title: Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 12 : 0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'RADIUS',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                'Pac',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  '5 HRS',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CupertinoSwitch(
                          value: Random().nextBool(),
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (activated) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'NONE',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                'Pac',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  'NA',
                                  style: const TextStyle(fontSize: 12),
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
            ),
          ),
        ],
      ),
    );
  }
}
