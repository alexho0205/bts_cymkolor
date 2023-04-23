import 'package:bts_cymkolor/api/SMS.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("search", () async {
    await dotenv.load(fileName: "assets/.env");
    TwilioServices twilioServices = TwilioServices();
    twilioServices.sendSMS("+886988033414", "Hello World test:verify_code:567900");
  });
}