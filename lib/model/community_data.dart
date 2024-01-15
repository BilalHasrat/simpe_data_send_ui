class CommunityData {
  int? status;
  String? message;
  ComData? data;

  CommunityData({this.status, this.message, this.data});

  CommunityData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ComData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ComData {
  String? from;
  List<String>? sendTo;

  ComData({this.from, this.sendTo});

  ComData.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    sendTo = json['send_to'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['send_to'] = this.sendTo;
    return data;
  }
}