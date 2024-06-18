import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/net/create_model_interceptor/create_model.interceptor.dart';

class WeatherInterceptor extends CreateModelInterceptor {
  const WeatherInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    json.toString().logD;
    return modelCreator(json);
  }
}
