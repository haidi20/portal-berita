// import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CounterBloc {
  int initialCount = 0;
  BehaviorSubject<int> _subjectCounter;

  CounterBloc(this.initialCount) {
    _subjectCounter = BehaviorSubject<int>(seedValue: initialCount);
  }

  Observable<int> get counterStream {
    return _subjectCounter.stream;
  }

  void increment() {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement() {
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose() {
    _subjectCounter.close();
  }
}

final counterBloc = CounterBloc;
