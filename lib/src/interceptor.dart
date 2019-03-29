
import 'dart:async';

typedef Future<bool> InterceptorFunc(String path);

class RouterInterceptor {
  List<InterceptorFunc> _interceptors = [];
  void add(InterceptorFunc interceptor) {
    _interceptors.add(interceptor);
  }
  Future<bool> execute(String path) async {
    if(_interceptors.isEmpty) {
      return true;
    }
    for(InterceptorFunc fun in _interceptors) {
      if(await fun(path)) {
        return false;
      }
    }
    return true;
  }
}

class PathBeenIntercepted implements Exception {
  final String message;
  final String path;
  PathBeenIntercepted(this.message, this.path);

  @override
  String toString() {
    return "$message '$path'";
  }
}