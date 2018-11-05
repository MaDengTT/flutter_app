import 'package:dio/dio.dart';



class ApiManager{
  factory ApiManager() => _getInstance();
  static ApiManager get instance => _getInstance();
  static ApiManager _instance;
  Dio dio;
  ApiManager._internal(){
      initDio();
    }

    Dio getDio(){
      return dio;
    }

    static ApiManager _getInstance(){
        if(_instance == null) {
          _instance = new ApiManager._internal();
        }
        return _instance;
      }

  void initDio() {
    dio = new Dio(new Options(
        baseUrl: "http://api.mdshi.cn",
        connectTimeout: 5000,
        receiveTimeout: 3000
    ));
    dio.interceptor.request.onSend = (Options options){
      // 在请求被发送之前做一些事情
      print('send request：url:${options.baseUrl}${options.path}');
      print('send request：url:${options.data}');
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    };
    dio.interceptor.response.onSuccess = (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    };
    dio.interceptor.response.onError = (DioError e){
      // 当请求失败时做一些预处理
      return e;//continue
    };

  }
}

Future<Response> login(String email,String phone,String password) async {
  Response response;
  FormData formData = new FormData.from({
    "phone":phone,
    "email":email,
    "password":password
  });
//  if(email!=null) {
//    response = await ApiManager.instance.dio.post("/user/login",data: {"email":email,"password":password});
//  }else{
//  }
  response = await ApiManager.instance.dio.post("/user/login",data:formData);
  return response;
}