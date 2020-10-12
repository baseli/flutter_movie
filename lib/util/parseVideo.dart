import 'dart:io';
import 'dart:async';
import 'dart:convert';

class ParseVideo {
  /// 解析vip视频地址
  static Future<String> parse(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.http("jiexi.peilili.com", "/jiexi2/api.php"));

    var data = utf8.encode('url=${Uri.encodeComponent(url)}&referer=aHR0cDovL2p4LjAzMTM1NTUuY29tLw%3D%3D&ref=0&time=${(new DateTime.now().millisecondsSinceEpoch / 1000).round()}&type=&other=${Uri.encodeComponent(base64Encode(utf8.encode(url)))}&ios=');

    request.headers
        ..add("Host", "jiexi.peilili.com")
        ..add("Accept", "application/json, text/javascript, */*; q=0.01")
        ..add("X-Requested-With", "XMLHttpRequest")
        ..add("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
        ..add("Origin", "http://jiexi.peilili.com")
        ..add("Referer", "http://jiexi.peilili.com/jiexi2/?url=" + url)
        ..add("Accept-Language", "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6");
    request.headers.contentLength = data.length;

    request.add(data);
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    httpClient.close();

    Map<String, dynamic> res = jsonDecode(responseBody);
    print(res);
    if (res["code"] == 200 && res["success"] == 1) {
      return res["url"];
    }
    return null;
  }
}