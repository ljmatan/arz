import 'dart:math';

import 'package:flutter/material.dart';

class AddTileDialog extends StatefulWidget {
  final String? code1, code2;
  final int? value1, value2, tileID;

  AddTileDialog({
    this.code1,
    this.value1,
    this.code2,
    this.value2,
    this.tileID,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddTileDialogState();
  }
}

class _AddTileDialogState extends State<AddTileDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _code1Controller;
  late TextEditingController _value1Controller;
  late TextEditingController _code2Controller;
  late TextEditingController _value2Controller;

  @override
  void initState() {
    super.initState();
    _code1Controller = TextEditingController(text: widget.code1 ?? '');
    _value1Controller =
        TextEditingController(text: widget.value1?.toString() ?? '');
    _code2Controller = TextEditingController(text: widget.code2 ?? '');
    _value2Controller =
        TextEditingController(text: widget.value2?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, MediaQuery.of(context).viewInsets.bottom),
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
                            padding: const EdgeInsets.only(bottom: 20, top: 4),
                            child: Text(
                              widget.tileID != null
                                  ? 'Edit Item Dialog'
                                  : 'Add Item Dialog',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  autofocus: true,
                                  controller: _code1Controller,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'L. Code',
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty)
                                      return 'Field must not be empty';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _value1Controller,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'L. Value',
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty)
                                      return 'Field must not be empty';
                                    else if (int.tryParse(text) == null)
                                      return 'Please enter a number';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _code2Controller,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'R. Code',
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty)
                                      return 'Field must not be empty';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _value2Controller,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'R. Value',
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty)
                                      return 'Field must not be empty';
                                    else if (int.tryParse(text) == null)
                                      return 'Please enter a number';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 44,
                                      child: Center(
                                        child: Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 44,
                                        child: Center(
                                          child: Text(
                                            'SUBMIT',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        final id =
                                            100000 + Random().nextInt(900000);
                                        Navigator.pop(context, {
                                          'id': widget.tileID ?? id,
                                          'lCode': _code1Controller.text,
                                          'lValue':
                                              int.parse(_value1Controller.text),
                                          'rCode': _code2Controller.text,
                                          'rValue':
                                              int.parse(_value2Controller.text),
                                        });
                                      }
                                    },
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _code1Controller.dispose();
    _value1Controller.dispose();
    _code2Controller.dispose();
    _value2Controller.dispose();
    super.dispose();
  }
}
