class bugModel {
  String? bug_id, bug_name , farm_id;
  bugModel({this.bug_id, this.bug_name,this.farm_id});
  bugModel.fromJson(Map<String, dynamic> json) {
    bug_id = json['bug_id'];
    bug_name = json['bug_name'];
    farm_id = json['farm_id'];
    
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_id'] = this.bug_id;
    data['bug_name'] = this.bug_name;
     data['farm_id'] = this.farm_id;
    return data;
  }
}
