class NotesModel {
  int? nId;
  String? nTitle;
  String? nContent;
  String? nImage;
  int? nUsers;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_id'] = this.nId;
    data['n_title'] = this.nTitle;
    data['n_content'] = this.nContent;
    data['n_image'] = this.nImage;
    data['n_users'] = this.nUsers;
    data['n_bookmark'] = this.n_bookmark;

    return data;
  }
}
