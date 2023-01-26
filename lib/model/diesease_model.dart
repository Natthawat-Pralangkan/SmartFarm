class DieseaseModel {
  String? diesease_id, diesease_name, farm_id;
  DieseaseModel({this.diesease_id, this.diesease_name, this.farm_id});
  DieseaseModel.fromJson(Map<String, dynamic> json) {
    diesease_id = json['diesease_id'];
    diesease_name = json['diesease_name'];
    farm_id = json['farm_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diesease_id'] = this.diesease_id;
    data['diesease_name'] = this.diesease_name;
    data['farm_id'] = this.farm_id;
    return data;
  }
}
