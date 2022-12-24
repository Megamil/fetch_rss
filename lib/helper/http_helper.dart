import 'package:fetch_rss/helper/secure_print.dart';
import 'package:http/http.dart';

class HttpHelper {

  static void toCurl(BaseRequest request) {
    final requestString = request.toString();
    final method = request.method;
    final url = request.url.toString();
    final headers = request.headers.map((key, value) => MapEntry(key, '-H "$key: $value"')).values.join(' ');

    SecurePrint.log(requestString);
    SecurePrint.log("CURL Start");
    SecurePrint.log('curl -X $method $headers "$url"');
    SecurePrint.log("CURL End");
  }

}