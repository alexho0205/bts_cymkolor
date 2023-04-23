class SendMailInfo {
  List<String> recipients;
  String subject;
  String body;

  SendMailInfo({
    required this.recipients,
    required this.subject,
    required this.body,
  });
}