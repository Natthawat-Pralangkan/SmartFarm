class GreehouseModel {
  String? farm_id,gh_id,gh_name,gh_status;
  GreehouseModel({this.farm_id, this.gh_id, this.gh_name, this.gh_status});
  GreehouseModel.fromJson(Map<String, dynamic> json) {
    farm_id = json['farm_id'];
    gh_id = json['gh_id'];
    gh_name = json['gh_name'];
    gh_status = json['gh_status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farm_id'] = this.farm_id;
    data['gh_id'] = this.gh_id;
    data['gh_name'] = this.gh_name;
    data['gh_status'] = this.gh_status;
    return data;
  }
}
