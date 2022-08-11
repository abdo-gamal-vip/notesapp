class NotesModel {
  int? nId;
  String? nTitle;
  String? nContent;
  String? nImage;
  int? nUsers;

  NotesModel({this.nId, this.nTitle, this.nContent, this.nImage, this.nUsers});

  NotesModel.fromJson(Map<String, dynamic> json) {
    nId = json['n_id'];
    nTitle = json['n_title'];
    nContent = json['n_content'];
    nImage = json['n_image'];
    nUsers = json['n_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_id'] = this.nId;
    data['n_title'] = this.nTitle;
    data['n_content'] = this.nContent;
    data['n_image'] = this.nImage;
    data['n_users'] = this.nUsers;
    return data;
  }
}
