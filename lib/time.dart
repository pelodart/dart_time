import 'package:sprintf/sprintf.dart';

class Time {
  // member data
  int _second;
  int _minute;
  int _hour;

  // c'tors
  Time(int second, int minute, int hour) {
    _second = (0 <= second && second < 60) ? second : 0;
    _minute = (0 <= minute && minute < 60) ? minute : 0;
    _hour = (0 <= hour && hour < 24) ? hour : 0;
  }

  // default c'tor
  Time.origin() {
    _second = 0;
    _minute = 0;
    _hour = 0;
  }

  // user-defined c'tors
  Time.fromSeconds(int seconds)
      : _second = 0,
        _minute = 0,
        _hour = 0 {
    if (0 <= seconds && seconds <= 24 * 60 * 60) {
      _secondsToTime(seconds);
    }
  }

  Time.fromJson(Map<String, int> json)
      : _second = 0,
        _minute = 0,
        _hour = 0,
        assert(json.containsKey('second')),
        assert(json.containsKey('minute')),
        assert(json.containsKey('hour')) {
    Second = json['second'];
    Minute = json['minute'];
    Hour = json['hour'];
  }

  Time.clone(Time time) {
    _second = time.Second;
    _minute = time.Minute;
    _hour = time.Hour;
  }

  // getters and setters
  int get Second => _second;
  int get Minute => _minute;
  int get Hour => _hour;

  set Second(int value) => _second = (0 <= value && value < 60) ? value : 0;
  set Minute(int value) => _minute = (0 <= value && value < 60) ? value : 0;
  set Hour(int value) => _hour = (0 <= value && value < 24) ? value : 0;

  // public interface
  void reset() {
    _second = 0;
    _minute = 0;
    _hour = 0;
  }

  void add(int second, int minute, int hour) {
    _second += second;
    _minute += minute;
    _hour += hour;

    // normalize object
    _minute += _second ~/ 60;
    _hour += _minute ~/ 60;
    _second = _second % 60;
    _minute = _minute % 60;
    _hour = _hour % 24;
  }

  void addTime(Time time) {
    this.add(time._second, time._minute, time._hour);
  }

  void sub(int second, int minute, int hour) {
    int seconds = _timeToSeconds() - (hour * 3600 + minute * 60 + second);
    if (seconds < 0) seconds += 24 * 60 * 60;
    _secondsToTime(seconds);
  }

  void subTime(Time time) {
    this.sub(time._second, time._minute, time._hour);
  }

  Time diff(Time time) {
    var result;
    if (this <= time || this == time) {
      result = new Time(time._second, time._minute, time._hour);
      result.subTime(this);
    } else {
      result = new Time(_second, _minute, _hour);
      result.subTime(time);
    }

    return result;
  }

  void increment() {
    _second++;
    if (_second >= 60) {
      _second = 0;
      _minute++;
      if (_minute >= 60) {
        _minute = 0;
        _hour++;
        if (_hour >= 24) {
          _hour = 0;
        }
      }
    }
  }

  void decrement() {
    _second--;
    if (_second < 0) {
      _second = 59;
      _minute--;
      if (_minute < 0) {
        _minute = 59;
        _hour--;
        if (_hour < 0) {
          _hour = 23;
        }
      }
    }
  }

  // comparison operators
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time &&
          _second == other._second &&
          _minute == other._minute &&
          _hour == other._hour;

  bool operator <=(Time time) {
    if (_hour < time._hour) return true;

    if (_hour == time._hour && _minute < time._minute) return true;

    if (_hour == time._hour &&
        _minute == time._minute &&
        _second < time._second) return true;

    return false;
  }

  bool operator <(Time time) {
    return this <= time && this != time;
  }

  bool operator >=(Time time) {
    return !(this < time);
  }

  bool operator >(Time time) {
    return !(this <= time);
  }

  // arithmetic operators
  Time operator +(Time time) {
    Time result = new Time.clone(this);
    result.add(time.Second, time.Minute, time.Hour);
    return result;
  }

  Time operator -(Time time) {
    Time result = new Time.clone(this);
    result.sub(time.Second, time.Minute, time.Hour);
    return result;
  }

  @override
  String toString() {
    return sprintf("Time: %02d:%02d:%02d", [_hour, _minute, _second]);
  }

  // private helper methods
  void _secondsToTime(int seconds) {
    // transform total seconds into hour, minute and second
    _hour = seconds ~/ 3600;
    seconds = seconds % 3600;
    _minute = seconds ~/ 60;
    _second = seconds % 60;
  }

  int _timeToSeconds() {
    return _hour * 3600 + _minute * 60 + _second;
  }
}
