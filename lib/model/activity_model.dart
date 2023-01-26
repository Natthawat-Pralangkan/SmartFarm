class ActivityModel {
  String? crop_id,
      work_date,
      work_detail,
      problem,
      cost,
      diesease_id,
      bug_id,
      activity_id,
      solve_by,
      farm_id;

 ActivityModel({
    this.crop_id,
    this.work_date,
    this.work_detail,
    this.problem,
    this.cost,
    this.diesease_id,
    this.bug_id,
    this.solve_by,
    this.activity_id,
    this.farm_id,
  });
  ActivityModel.fromJson(Map<String, dynamic> json) {
    activity_id = json['activity_id'];
    crop_id = json['crop_id'];
    work_date = json['work_date'];
    work_detail = json['work_detail'];
    problem = json['problem'];
    cost = json['cost'];
    diesease_id = json['diesease_id'];
    bug_id = json['bug_id'];
    solve_by = json['solve_by'];
    farm_id = json['farm_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activity_id;
    data['crop_id'] = this.crop_id;
    data['work_date'] = this.work_date;
    data['work_detail'] = this.work_detail;
    data['problem'] = this.problem;
    data['cost'] = this.cost;
    data['diesease_id'] = this.diesease_id;
    data['bug_id'] = this.bug_id;
    data['solve_by'] = this.solve_by;
    data['farm_id'] = this.farm_id;

    return data;
  }
}
