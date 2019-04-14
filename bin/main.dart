import '../lib/time.dart';

void main() {
  testingConstructors();
  testingIncrement();
  testingDecrement();
  testingDiff();
  testingArithmeticOperators();
}

void testingConstructors() {
  var t1 = new Time(0, 0, 0);
  var t2 = new Time(59, 59, 23);
  var t3 = new Time(59, 60, 23);
  var t4 = new Time.origin();
  var t5 = new Time.fromSeconds(60 * 60 * 24 - 1);
  var t6 = new Time.fromJson({'second': 0, 'minute': 0, 'hour': 12});

  print(t1.toString());
  print(t2.toString());
  print(t3.toString());
  print(t4.toString());
  print(t5.toString());
  print(t6.toString());
}

void testingIncrement() {
  var time = new Time(55, 59, 23);
  for (int i = 0; i < 8; i++) {
    time.increment();
    print(time.toString());
  }
}

void testingDecrement() {
  var time = new Time(5, 0, 0);
  for (int i = 0; i < 8; i++) {
    time.decrement();
    print(time.toString());
  }
}

void testingDiff() {
  var t1 = new Time.origin();
  var t2 = new Time.fromJson({'second': 59, 'minute': 59, 'hour': 23});
  var t3 = t1.diff(t2);
  print(t3.toString());
  t3 = t2.diff(t1);
  print(t3.toString());
}

void testingArithmeticOperators() {
  var t1 = new Time(15, 30, 6);
  Time t2 = t1 + t1;
  print(t2.toString());
  t2 += t1;
  print(t2.toString());
  t2 -= new Time.fromSeconds(120);
  print(t2.toString());
  t2 -= t1;
  print(t2.toString());
}
