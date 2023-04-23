import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TwilioServices{
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: '${dotenv.env['TWILIO_ACCOUNT_SID']}', // found on console
      authToken: '${dotenv.env['TWILIO_AUTH_TOKEN']}',     // found on console
      twilioNumber: '${dotenv.env['TWILIO_PHONE_NUMBER']}' // trial phone number is the one from which the messages will be sent. It will probably be a USA phone number.
  );
  void sendSMS(String PhoneNum, String MessageBody)
  {
    twilioFlutter.sendSMS(toNumber: PhoneNum, messageBody: MessageBody);
  }
}
