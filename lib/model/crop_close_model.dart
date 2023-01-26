class CloseCropModel {
  String? crop_id, close_date, amount, cost, farm_id;

  CloseCropModel({
    this.crop_id,
    this.close_date,
    this.amount,
    this.cost,
    this.farm_id,
  });
  CloseCropModel.fromJson(Map<String, dynamic> json) {
    crop_id = json['crop_id'];
    close_date = json['close_date'];
    amount = json['amount'];
    cost = json['cost'];
    farm_id = json['farm_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crop_id'] = this.crop_id;
    data['close_date'] = this.close_date;
    data['amount'] = this.amount;
    data['cost'] = this.cost;
    data['farm_id'] = this.farm_id;
    return data;
  }
}
