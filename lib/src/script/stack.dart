
part of 'script.dart';
class StackException implements Exception {
  final String message;
  final int code;

  StackException(this.code, this.message);

  String toString(){
    return 'StackException($code, $message)';
  }
}

class Stack<E> {
  final List _list = <E>[];

  int _maxSize = 0;
  final int noLimit = -1;

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  Stack.sized(int maxSize) {
    if (maxSize < 2){
      throw StackException(-1, 'too small');
    }
  }

  void push(E element){
    if(_maxSize == noLimit || _list.length < _maxSize){
      _list.add(element);
    } else {
      throw StackException(2,'Error: cannot add element. Stack already at maximum size of: $_maxSize elements' );
    }
  }

  E pop(){
    if (isEmpty) {
      throw StackException(1, "Cannot use pop with an empty stack");
    }
    E result = _list.last;
    _list.removeLast();
    return result;
  }

  E top() {
    if(isEmpty) {
      throw StackException(3, 'Cannot use top with an empty stack');
    }
    return _list.last;
  }

  int size() {
    return _list.length;
  }

  int get length => size();

  bool contains(E element) {
    return _list.contains(element);
  }

  void print(){
    for ( var item in List<E>.from(_list).reversed){
      core.print(item);
    }
  }

  @override
  String toString() => _list.toString();
}
