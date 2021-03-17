import 'package:arz/logic/cache/prefs.dart';
import 'package:arz/ui/screens/home/add_menu_tile.dart';
import 'package:arz/ui/screens/home/tile_details/tile_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SwipeDirection { ltr, rtl }

class SlideTile extends StatefulWidget {
  final Map tileInfo;
  final Function removeTile, updateTile;

  SlideTile({
    required this.tileInfo,
    required this.removeTile,
    required this.updateTile,
  });

  @override
  _SlideTileState createState() => _SlideTileState();
}

class _SlideTileState extends State<SlideTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _controller.value = 0.5;
    _animation =
        Tween(begin: const Offset(0.3, 0.0), end: const Offset(-0.3, 0.0))
            .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (data) => setState(
          () => _controller.value -= data.primaryDelta! / context.size!.width),
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity! > 1500)
          _controller.animateTo(.0);
        else if (data.primaryVelocity! < -1500)
          _controller.animateTo(1.0);
        else
          _controller.animateTo(0.5);
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TileDetailsScreen())),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close),
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 18,
                                                ),
                                                child: Text(
                                                  'Are you sure you want to delete this?',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      onPrimary:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      primary:
                                                          Colors.transparent,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      widget.removeTile(widget
                                                          .tileInfo['id']);
                                                    },
                                                    child: Text('YES'),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      onPrimary: Colors.white,
                                                      primary: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('NO'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final newData = await showDialog(
                                    context: context,
                                    barrierColor: Colors.white70,
                                    builder: (context) => AddTileDialog(
                                      tileID: widget.tileInfo['id'],
                                      code1: widget.tileInfo['lCode'],
                                      value1: widget.tileInfo['lValue'],
                                      code2: widget.tileInfo['rCode'],
                                      value2: widget.tileInfo['rValue'],
                                    ),
                                  );
                                  if (newData != null)
                                    widget.updateTile(newData);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SlideTransition(
            position: _animation,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[1],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                widget.tileInfo['lCode'],
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
                                '${widget.tileInfo['lValue']} HRS',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, newState) => CupertinoSwitch(
                      value:
                          Prefs.instance.getBool('${widget.tileInfo['id']}') ??
                              false,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (activated) async {
                        await Prefs.instance
                            .setBool('${widget.tileInfo['id']}', activated);
                        newState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                widget.tileInfo['rCode'],
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
                                '${widget.tileInfo['rValue']} HRS',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
