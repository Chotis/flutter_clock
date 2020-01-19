// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element { background, text, shadow, imageName }

final _lightTheme = {
  _Element.background: Color(0xFFb9c6ca),
  _Element.text: Colors.white,
  _Element.shadow: Colors.white,
  _Element.imageName: "day"
};

final _darkTheme = {
  _Element.background: Color(0xFF202b4d),
  _Element.text: Colors.white,
  _Element.shadow: Colors.white,
  _Element.imageName: "night"
};

class PansClock extends StatefulWidget {
  const PansClock(this.model);

  final ClockModel model;

  @override
  _PansClockState createState() => _PansClockState();
}

class _PansClockState extends State<PansClock> {
  var _temperature = '';
  var _condition = '';
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(PansClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    var imageToUse = Theme.of(context).brightness == Brightness.light
        ? _lightTheme.values.elementAt(3)
        : _darkTheme.values.elementAt(3);

    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final seconds = DateFormat('ss').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 7;

    final weatherInfo = DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 30.0,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.blue,
          shadows: [
            Shadow(
              blurRadius: 0,
              color: colors[_Element.shadow],
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: FlareActor(
                    'assets/animations/$_condition.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: _condition,
                  ),
                )),
                Container(child: Text(_temperature)),
              ],
            )));

    final defaultStyle = TextStyle(
      fontFamily: 'Autour',
      fontSize: fontSize,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.blue,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[_Element.shadow],
          offset: Offset(1, 0),
        ),
      ],
    );
    //This could very likely be created a lot more elegantly
    //than what I've got below.
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage('assets/images/$imageToUse.jpg'),
                fit: BoxFit.fill)),
        child: Container(
            child: Center(
                child: SizedBox(
          width: 800,
          height: 400,
          child: Material(
            elevation: 20.0,
            color: Colors.transparent,
            child: DefaultTextStyle(
              style: defaultStyle,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              new AssetImage('assets/images/$imageToUse.jpg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      weatherInfo,
                      Align(
                          alignment: Alignment.center,
                          child: Text('$hour:$minute:$seconds')),
                    ],
                  )),
            ),
          ),
        ))));
  }
}
