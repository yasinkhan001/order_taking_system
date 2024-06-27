import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class DurationTimer extends StatefulWidget {
  const DurationTimer({required this.futureDate, super.key, this.builder});
  final DateTime futureDate;
  final Widget Function(BuildContext, DurationModel, Widget?)? builder;
  @override
  State<DurationTimer> createState() => _DurationTimerState();
}

class _DurationTimerState extends State<DurationTimer> {
  Duration durationLeft = Duration.zero;
  ValueNotifier<DurationModel> time = ValueNotifier(
      DurationModel(days: 00, hours: 00, minutes: 00, seconds: 00));

  void startTimer(DateTime targetDateTime, Function callback) {
    durationLeft = targetDateTime.difference(DateTime.now());
    int countdownInSeconds = durationLeft.inSeconds;
    if (durationLeft.isNegative) return;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        if (durationLeft.inSeconds > 0) {
          time.value = DurationModel(
              days: countdownInSeconds ~/ (24 * 3600),
              hours: (countdownInSeconds % (24 * 3600)) ~/ 3600,
              minutes: (countdownInSeconds % 3600) ~/ 60,
              seconds: countdownInSeconds % 60);

          countdownInSeconds--;
        } else {
          timer.cancel();
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer(widget.futureDate, () {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DurationModel>(
        valueListenable: time,
        builder: widget.builder ??
            (context, duration, child) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border.all(color: const Color(0x26080c52), width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // _tile(val: '${duration.days}', title: 'Days'),
                      _tile(val: '${duration.hours}', title: 'Hours'),
                      _tile(val: '${duration.minutes}', title: 'Min'),
                      _tile(val: '${duration.seconds}', title: 'Sec'),
                    ],
                  ),
                ));
  }

  Widget _tile({required String val, required String title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(val.length < 2 ? "0$val" : val,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 22,
                )),
        const SizedBox(
          height: 6,
        ),
        Text(title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                )),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    time.dispose();
  }
}

class DurationModel {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  DurationModel({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  DurationModel copyWith({
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
  }) =>
      DurationModel(
        days: days ?? this.days,
        hours: hours ?? this.hours,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
      );

  factory DurationModel.fromRawJson(String str) =>
      DurationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DurationModel.fromJson(Map<String, dynamic> json) => DurationModel(
        days: json["days"],
        hours: json["hours"],
        minutes: json["minutes"],
        seconds: json["seconds"],
      );

  Map<String, dynamic> toJson() => {
        "days": days,
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
      };
}
