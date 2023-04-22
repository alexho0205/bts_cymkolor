import 'package:flutter_test/flutter_test.dart';
import 'package:bts_cymkolor/api/g2rail_api_client.dart';
import 'package:http/http.dart' as http;

main() {
  test("search", () async {
    var client = GrailApiClient(
        httpClient: http.Client(),
        baseUrl: "http://alpha.api.g2rail.com",
        apiKey: "fa656e6b99d64f309d72d6a8e7284953",
        secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");
    var rtn = await client.getSolutions(
        "BERLIN", "FRANKFURT", "2023-04-23", "10:00", 1, 0);
    print(rtn.toString());
    var rtn2 = await client.getAsyncResult(rtn.toString());
    print(rtn2.toString());
  });

  // test("getResult", () async {
  //   var client = GrailApiClient(
  //       httpClient: http.Client(),
  //       baseUrl: "http://alpha.api.g2rail.com",
  //       apiKey: "fa656e6b99d64f309d72d6a8e7284953",
  //       secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");

  // });
}
