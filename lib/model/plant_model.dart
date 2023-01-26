class PlantModel {
  String? plant_id, plant_name, age, ph, temp_max, temp_min, farm_id;

  PlantModel(
      {this.plant_id,
      this.plant_name,
      this.age,
      this.ph,
      this.temp_max,
      this.temp_min,
      this.farm_id});
  PlantModel.fromJson(Map<String, dynamic> json) {
    plant_id = json['plant_id'];
    plant_name = json['plant_name'];
    age = json['age'];
    ph = json['ph'];
    temp_max = json['temp_max'];
    temp_min = json['temp_min'];
    farm_id = json['farm_id'];
    
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plant_id'] = this.plant_id;
    data['plant_name'] = this.plant_name;
    data['age'] = this.age;
    data['ph'] = this.ph;
    data['temp_max'] = this.temp_max;
    data['temp_min'] = this.temp_min;
    data['farm_id'] = this.farm_id;
    return data;
  }
}
