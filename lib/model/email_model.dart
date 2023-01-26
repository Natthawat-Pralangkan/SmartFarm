class EmailModel {
  String? farm_id;
  String? farm_name;
  String? address;
  String? tumbon;
  String? amphur;
  String? province;
  String? email;
  String? password;
  String? typeuser;
  String? lat;
  String? Lng;

  EmailModel(
      {this.farm_id,
      this.farm_name,
      this.address,
      this.tumbon,
      this.amphur,
      this.province,
      this.email,
      this.password,
      this.typeuser,
      this.lat,
      this.Lng});

  EmailModel.fromJson(Map<String, dynamic> json) {
    farm_id = json['farm_id'];
    farm_name = json['farm_name'];
    address = json['address'];
    tumbon = json['tumbon'];
    amphur = json['amphur'];
    province = json['province'];
    email = json['email'];
    password = json['password'];
    typeuser = json['typeuser'];
    lat = json['lat'];
    Lng = json['Lng'];
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farm_id'] = this.farm_id;
    data['farm_name'] = this.farm_name;
    data['address'] = this.address;
    data['tumbon'] = this.tumbon;
    data['amphur'] = this.amphur;
    data['province'] = this.province;
    data['email'] = this.email;
    data['password'] = this.password;
    data['typeuser'] = this.typeuser;
    data['lat'] = this.lat;
    data['Lng'] = this.Lng;
    
    return data;
  }
}
