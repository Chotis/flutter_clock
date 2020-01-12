// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  var _temperature = '';
  var _condition = '';
  var _location = '';
  Color _colorBegin_1 = Color(0xffD38312);
  Color _colorEnd_1 = Color(0xffD38312);
  Color _colorBegin_2 = Color(0xffD38312);
  Color _colorEnd_2 = Color(0xffD38312);
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    _updateColor();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
      _updateColor();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    //widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateColor() {
    setState(() {
      if (DateTime.now().hour >= 0 && DateTime.now().hour < 1) {
        _colorBegin_1 = Color(0xff00000c);
        _colorEnd_1 = Color(0xff00000c);
        _colorBegin_2 = Color(0xff00000c);
        _colorEnd_2 = Color(0xff00000c);
      } else if (DateTime.now().hour >= 1 && DateTime.now().hour < 2) {
        _colorBegin_1 = Color(0xff020111);
        _colorEnd_1 = Color(0xff020111);
        _colorBegin_2 = Color(0xff191621);
        _colorEnd_2 = Color(0xff191621);
      } else if (DateTime.now().hour >= 2 && DateTime.now().hour < 3) {
        _colorBegin_1 = Color(0xff020111);
        _colorEnd_1 = Color(0xff020111);
        _colorBegin_2 = Color(0xff20202c);
        _colorEnd_2 = Color(0xff20202c);
      } else if (DateTime.now().hour >= 3 && DateTime.now().hour < 4) {
        _colorBegin_1 = Color(0xff020111);
        _colorEnd_1 = Color(0xff020111);
        _colorBegin_2 = Color(0xff3a3a52);
        _colorEnd_2 = Color(0xff3a3a52);
      } else if (DateTime.now().hour >= 4 && DateTime.now().hour < 5) {
        _colorBegin_1 = Color(0xff20202c);
        _colorEnd_1 = Color(0xff20202c);
        _colorBegin_2 = Color(0xff515175);
        _colorEnd_2 = Color(0xff515175);
      } else if (DateTime.now().hour >= 5 && DateTime.now().hour < 6) {
        _colorBegin_1 = Color(0xff40405c);
        _colorEnd_1 = Color(0xff6f71aa);
        _colorBegin_2 = Color(0xff8a76ab);
        _colorEnd_2 = Color(0xff8a76ab);
      } else if (DateTime.now().hour >= 6 && DateTime.now().hour < 7) {
        _colorBegin_1 = Color(0xff4a4969);
        _colorEnd_1 = Color(0xff7072ab);
        _colorBegin_2 = Color(0xffcd82a0);
        _colorEnd_2 = Color(0xffcd82a0);
      } else if (DateTime.now().hour >= 7 && DateTime.now().hour < 8) {
        _colorBegin_1 = Color(0xff757abf);
        _colorEnd_1 = Color(0xff8583be);
        _colorBegin_2 = Color(0xffeab0d1);
        _colorEnd_2 = Color(0xffeab0d1);
      } else if (DateTime.now().hour >= 8 && DateTime.now().hour < 9) {
        _colorBegin_1 = Color(0xff82addb);
        _colorEnd_1 = Color(0xff82addb);
        _colorBegin_2 = Color(0xffebb2b1);
        _colorEnd_2 = Color(0xffebb2b1);
      } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 10) {
        _colorBegin_1 = Color(0xff94c5f8);
        _colorEnd_1 = Color(0xffa6e6ff);
        _colorBegin_2 = Color(0xffb1b5ea);
        _colorEnd_2 = Color(0xffb1b5ea);
      } else if (DateTime.now().hour >= 10 && DateTime.now().hour < 11) {
        _colorBegin_1 = Color(0xffb7eaff);
        _colorEnd_1 = Color(0xffb7eaff);
        _colorBegin_2 = Color(0xff94dfff);
        _colorEnd_2 = Color(0xff94dfff);
      } else if (DateTime.now().hour >= 11 && DateTime.now().hour < 12) {
        _colorBegin_1 = Color(0xff9be2fe);
        _colorEnd_1 = Color(0xff9be2fe);
        _colorBegin_2 = Color(0xff67d1fb);
        _colorEnd_2 = Color(0xff67d1fb);
      } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 13) {
        _colorBegin_1 = Color(0xff90dffe);
        _colorEnd_1 = Color(0xff90dffe);
        _colorBegin_2 = Color(0xff38a3d1);
        _colorEnd_2 = Color(0xff38a3d1);
      } else if (DateTime.now().hour >= 13 && DateTime.now().hour < 14) {
        _colorBegin_1 = Color(0xff57c1eb);
        _colorEnd_1 = Color(0xff57c1eb);
        _colorBegin_2 = Color(0xff246fa8);
        _colorEnd_2 = Color(0xff246fa8);
      } else if (DateTime.now().hour >= 14 && DateTime.now().hour < 15) {
        _colorBegin_1 = Color(0xff2d91c2);
        _colorEnd_1 = Color(0xff2d91c2);
        _colorBegin_2 = Color(0xff1e528e);
        _colorEnd_2 = Color(0xff1e528e);
      } else if (DateTime.now().hour >= 15 && DateTime.now().hour < 16) {
        _colorBegin_1 = Color(0xff2473ab);
        _colorEnd_1 = Color(0xff1e528e);
        _colorBegin_2 = Color(0xff1e528e);
        _colorEnd_2 = Color(0xff5b7983);
      } else if (DateTime.now().hour >= 16 && DateTime.now().hour < 17) {
        _colorBegin_1 = Color(0xff1e528e);
        _colorEnd_1 = Color(0xff265889);
        _colorBegin_2 = Color(0xff265889);
        _colorEnd_2 = Color(0xff9da671);
      } else if (DateTime.now().hour >= 17 && DateTime.now().hour < 18) {
        _colorBegin_1 = Color(0xff1e528e);
        _colorEnd_1 = Color(0xff728a7c);
        _colorBegin_2 = Color(0xffe9ce5d);
        _colorEnd_2 = Color(0xffe9ce5d);
      } else if (DateTime.now().hour >= 18 && DateTime.now().hour < 19) {
        _colorBegin_1 = Color(0xff154277);
        _colorEnd_1 = Color(0xff576e71);
        _colorBegin_2 = Color(0xffe1c45e);
        _colorEnd_2 = Color(0xffb26339);
      } else if (DateTime.now().hour >= 19 && DateTime.now().hour < 20) {
        _colorBegin_1 = Color(0xff4F4F47);
        _colorEnd_1 = Color(0xffC5752D);
        _colorBegin_2 = Color(0xffB7490F);
        _colorEnd_2 = Color(0xff2F1107);
      } else if (DateTime.now().hour >= 20 && DateTime.now().hour < 21) {
        _colorBegin_1 = Color(0xff071B26);
        _colorEnd_1 = Color(0xff071B26);
        _colorBegin_2 = Color(0xff8A3B12);
        _colorEnd_2 = Color(0xff240E03);
      } else if (DateTime.now().hour >= 21 && DateTime.now().hour < 22) {
        _colorBegin_1 = Color(0xff010A10);
        _colorEnd_1 = Color(0xff59230B);
        _colorBegin_2 = Color(0xff59230B);
        _colorEnd_2 = Color(0xff2F1107);
      } else if (DateTime.now().hour >= 22 && DateTime.now().hour < 23) {
        _colorBegin_1 = Color(0xff090401);
        _colorEnd_1 = Color(0xff090401);
        _colorBegin_2 = Color(0xff4B1D06);
        _colorEnd_2 = Color(0xff4B1D06);
      } else if (DateTime.now().hour >= 23 && DateTime.now().hour < 24) {
        _colorBegin_1 = Color(0xff00000c);
        _colorEnd_1 = Color(0xff00000c);
        _colorBegin_2 = Color(0xff150800);
        _colorEnd_2 = Color(0xff150800);
      }
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
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
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final seconds = DateFormat('ss').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 6;
    final offset = -fontSize / 7;

    final weatherInfo = DefaultTextStyle(
        style: TextStyle(color: Colors.black38, fontSize: 50.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_temperature),
          Text(_condition),
          Text(_location),
        ]));

    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'Heebo',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[_Element.shadow],
          offset: Offset(10, 0),
        ),
      ],
    );

    //Add if statements to print icon or flare animation for different conditions e.g. sunny shows a sun icon/animation etc.

    //Action plan if statements with different hours here which will change the gradients to correct colours
    //if time allows add weather conditions to make sure that gradients are slightly different colors for the different conditions
    print(DateTime.now().hour);
    var tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: _colorBegin_1, end: _colorEnd_1)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: _colorBegin_2, end: _colorEnd_2))
    ]);
    return ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [animation["color1"], animation["color2"]])),
            child: Center(
              child: DefaultTextStyle(
                style: defaultStyle,
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Text('$hour:$minute:$seconds')),
                    Align(alignment: Alignment.centerLeft, child: weatherInfo),
                  ],
                )),
              ),
            ),
          );
        });
  }
}
