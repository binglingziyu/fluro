
import 'dart:async';

typedef Future<bool> InterceptorFunc(String path);

class RouterInterceptor {
  List<InterceptorFunc> _interceptors = [];
  void add(InterceptorFunc interceptor) {
    _interceptors.add(interceptor);
  }
  Future<bool> execute(String path) async {
    if(_interceptors.isEmpty) {
      return false;
    }
    for(InterceptorFunc fun in _interceptors) {
      if(await fun(path)) {
        return true;
      }
    }
    return false;
  }
}

class RouterBeenIntercepted implements Exception {
  final String message;
  final String path;
  RouterBeenIntercepted(this.message, this.path);

  @override
  String toString() {
    return "$message '$path'";
  }
}