

class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;

  TaskModel(
      {this.sId,
      this.title,
      this.description,
      this.status,
      this.email,
      this.createdDate});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> TaskModel = new Map<String, dynamic>();
    TaskModel['_id'] = this.sId;
    TaskModel['title'] = this.title;
    TaskModel['description'] = this.description;
    TaskModel['status'] = this.status;
    TaskModel['email'] = this.email;
    TaskModel['createdDate'] = this.createdDate;
    return TaskModel;
  }
}
