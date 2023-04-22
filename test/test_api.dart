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
    /*var rtn = await client.getSolutions(
        "CT_LV7D0LYK2", "CT_LV7D1LOK2", "2023-04-24", "10:00", 1, 0);
    print(rtn.toString());
    var rtn2 = await client.getAsyncResult(rtn.toString());
    print(rtn2[1].toString());*/

    List<Passengers> passengers = [];
    passengers.add(Passengers(
        lastName: "zhang",
        firstName: "san",
        birthdate: "1986-09-01",
        passport: "A123456",
        email: "x@a.cn",
        phone: "+8615000367081",
        gender: "male"));
    List<String> sections = ["P_9JD3FG"];

    /*var rtn3 = await client.getOnlineOrders(
        passengers, sections, true, "partner_order_id");
    print(rtn3.toString());
    var rtn4 =
        await client.getOrdersAsyncResult("0433a0133681da6a2d02046c789567fa");
    print(rtn4.toString());*/

    /*var rtn5 = await client.getConfirmOrders("OD_9MJZ658YD");
    print(rtn5.toString());
    var rtn6 =
        await client.getConfirmAsyncResult("64fac098963f7784e61407f967de825f");
    print(rtn6.toString());*/

    var rtn7 = await client.getDownLoadTicketAsyncResult("OC_10E6XXVYN");
    print(rtn7.toString());
  });

  // test("getResult", () async {
  //   var client = GrailApiClient(
  //       httpClient: http.Client(),
  //       baseUrl: "http://alpha.api.g2rail.com",
  //       apiKey: "fa656e6b99d64f309d72d6a8e7284953",
  //       secret: "9a52b1f7-7c96-4305-8569-1016a55048bc");

  // });
}
