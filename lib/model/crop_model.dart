class CropModel {
  String? farm_id, crop_id, plant_id, crop_date, gh_id;

  CropModel(
      {this.farm_id, this.crop_id, this.plant_id, this.crop_date, this.gh_id});
  CropModel.fromJson(Map<String, dynamic> json) {
    farm_id = json['farm_id'];
    crop_id = json['crop_id'];
    plant_id = json['plant_id'];
    crop_date = json['crop_date'];
    gh_id = json['gh_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farm_id'] = this.farm_id;
    data['crop_id'] = this.crop_id;
    data['plant_id'] = this.plant_id;
    data['crop_date'] = this.crop_date;
    data['gh_id'] = this.gh_id;
    return data;
  }
}
