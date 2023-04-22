class DownLoadTicketModel {
  String? file;
  String? type;

  DownLoadTicketModel({
    this.file,
    this.type,
  });

  DownLoadTicketModel.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['file'] = file;
    data['type'] = type;
    return data;
  }
}
