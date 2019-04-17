## Die Klasse ``Time``

Entwerfen Sie eine Klasse Time, die eine Uhrzeit mit Stunden-, Minuten- und Sekundenanteil repräsentiert. Die Stunde kann Werte zwischen 0 und 23 einnehmen, die Minuten und Sekunden Werte zwischen 0 und 59.

Weitere Hinweise zur Spezifikation der Klasse ``Time`` finden Sie nachstehend vor:

### Konstruktoren
	
* ``Time(int second, int minute, int hour);``
* ``Time.origin()``
* ``Time.fromSeconds(int seconds);``
* ``Time.fromJson(Map<String, int> json);``
* ``Time.clone(Time time);``

Neben dem Standardkonstruktur besitzt die Klasse noch mehrere benutzerdefinierte Konstruktoren. Der Standardkonstruktur belegt ein ``Time``-Objekt mit den drei Werten ``second``, ``minute`` und ``hour`` vor. Mit dem benannten Konstruktor ``Time.fromSeconds`` kann man ein ``Time``-Objekt durch Angabe eines Sekundenwerts – im Bereich von 0 bis 86400 – vorbelegen. Alternativ lässt sich eine Uhrzeit auch durch eine Zeichenkette im JSON-Formats, z.B. ``"{ 'second': 1, 'minute': 2, 'hour': 3 }"`` spezifizieren. Programmiersprachlich besitzt dieser Konstruktor einen Parameter des Typs ``Map<String, int>``. Zum Kopieren von ``Time``-Objekt kommt der benannte Konstruktor ``Time.clone`` ins Spiel.

### Methoden

Im Folgenden finden Sie eine Reihe von Methoden aufgelistet, die elementare Funktionen mit Uhrzeiten ausüben wie z.B. die Addition oder Subtraktion zweier Uhrzeiten, natürlich unter entsprechender Berücksichtigung eines Über- oder Unterlaufs. Die Differenz zweier Uhrzeiten kann man ebenfalls bilden; auch lässt sich ein einzelnes  ``Time``-Objekt sekundenweise inkrementieren oder dekrementieren.

*Hinweis*: Im Gegensatz zu einer Reihe anderer Programmiersprache unterstützt Dart das Feature des *Überladens von Methoden* nicht; die beiden Methoden ``add`` und ``addTime`` vollziehen diesselbe Funktionalität (wie auch ``sub`` und ``subTime``).

* ``void reset();``
* ``void add(int second, int minute, int hour);``
* ``void addTime(Time time);``
* ``void sub(int second, int minute, int hour);``
* ``void subTime(Time time);``
* ``Time diff(Time time);``
* ``void increment();``
* ``void decrement();``

### getter und setter

getter und setter sind spezielle Methoden, um den - geschützten - lesenden und schreibenden Zugriff auf die relevanten Instanzvariablen eines Objekts zu ermöglichen. In unserem Beispiel bieten sich diese Methoden ``Second``, ``Minute`` und ``Hour`` für die drei Instanzvariablen zur Ablage des Sekunden-, Minuten- und Stundenwerts an. Ein weiterer getter ``Seconds`` wandelt eine Uhrzeit in Sekunden um - das Gegenstück zu diesem getter gibt es in Gestalt des Konstruktors ``Time.fromSeconds``:

* ``int get Second;``
* ``int get Minute;``
* ``int get Hour;``
* ``set Second(int value);``
* ``set Minute(int value);``
* ``set Hour(int value);``
* ``int get Seconds;``

### Operatoren

Uhrzeiten lassen sich vergleichen. In einer Programmiersprache, die das Überladen von Operatoren unterstützt, sollte man hierzu die entsprechenden Vergleichsoperatoren überladen:

* ``@override bool operator ==(Object other);``
* ``bool operator <=(Time time);``
* ``bool operator <(Time time);``
* ``bool operator >=(Time time);``
* ``set Minute(int value);``
* ``bool operator >(Time time);``

*Hinweis*: Der ``==``-Operator wird von der universellen Basisklasse ``Object`` an seine abgeleiteten Klassen vererbt. Aus diesem Grund ist dieser Operator mit der Annotation ``@override`` zu versehen und der Typ des Parameters universell als ``Object`` zu definieren - also nicht vom Typ ``Time``, wie man in diesem Beispiel meinen könnte.

Neben vergleichenden Operatoren (*comparison operators*) bieten sich für ``Time``-Objekt auch arithmetische Operatoren wie + oder - an. Die entsprechenden Methoden add und sub haben Sie hierfür schon realisiert, Sie sollten sie bei der Implementierung der arithmetischen Operatoren wiederverwenden:

* ``Time operator +(Time time);``
* ``Time operator -(Time time);``

### Kontrakt mit der universellen Basisklasse ``Object``

Alle Dart-Objekte leiten sich - direkt oder indirekt - von der universellen Basisklasse ``Object`` ab. Dies hat neben den Auswirkungen auf die Operatoren einer Klasse - siehe den Abschnitt zuvor - auch zur Folge, dass eine Methode ``toString`` zu überschreiben ist. Sie ist dafür verantwortlich, den Zustand eines Objekts in Zeichenkettennotation darzustellen:

``@override``  
``String toString();``

### Testrahmen

Testen Sie Ihre Implementierung mit einem möglichst umfangreichen Testrahmen. Das nachfolgende Code-Fragment soll eine Anregung darstellen:

```dart
import 'package:sprintf/sprintf.dart';

import '../lib/time.dart';

void main() {
  testingConstructors();
  testingIncrement();
  testingDecrement();
  testingDiff();
  testingArithmeticOperators();
  testingDiff();
  testingTimeToSeconds();
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

void testingTimeToSeconds() {
  print('Begin');
  var start = new DateTime.now().millisecondsSinceEpoch;

  for (var i = 0; i < 24 * 60 * 60; i++) {
    Time t = Time.fromSeconds(i);
    int seconds = t.Seconds;
    assert(i == seconds);
  }
  var duration = new DateTime.now().millisecondsSinceEpoch - start;
  print(sprintf('Done [%d msecs]', [duration]));
}
```

**Ausgabe**:

```dart
Time: 00:00:00
Time: 23:59:59
Time: 23:00:59
Time: 00:00:00
Time: 23:59:59
Time: 12:00:00
Time: 23:59:56
Time: 23:59:57
Time: 23:59:58
Time: 23:59:59
Time: 00:00:00
Time: 00:00:01
Time: 00:00:02
Time: 00:00:03
Time: 00:00:04
Time: 00:00:03
Time: 00:00:02
Time: 00:00:01
Time: 00:00:00
Time: 23:59:59
Time: 23:59:58
Time: 23:59:57
Time: 23:59:59
Time: 23:59:59
Time: 13:00:30
Time: 19:30:45
Time: 19:28:45
Time: 12:58:30
Time: 23:59:59
Time: 23:59:59
Begin
Done [5 msecs]
```