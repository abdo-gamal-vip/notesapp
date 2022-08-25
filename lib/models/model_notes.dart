// ignore_for_file: non_constant_identifier_names

class NotesModel {
  String? nId;
  String? nTitle;
  String? nContent;
  String? nImage;
  String? nUsers;
  String? n_bookmark;

  NotesModel(
      {this.nId,
      this.nTitle,
      this.nContent,
      this.nImage,
      this.nUsers,
      this.n_bookmark});

  NotesModel.fromJson(Map<String, dynamic> json) {
    nId = json['n_id'];
    nTitle = json['n_title'];
    nContent = json['n_content'];
    nImage = json['n_image'];
    nUsers = json['n_users'];
    n_bookmark = json['n_bookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n_id'] = nId;
    data['n_title'] = nTitle;
    data['n_content'] = nContent;
    data['n_image'] = nImage;
    data['n_users'] = nUsers;
    data['n_bookmark'] = n_bookmark;

    return data;
  }
}
