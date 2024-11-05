import 'package:dio/dio.dart';
import 'package:f_journey/core/network/interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio(BaseOptions(baseUrl: '${dotenv.env['BASE_API_URL']}'))
  ..interceptors.add(DioInterceptor());
