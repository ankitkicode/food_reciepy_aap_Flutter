// muliple data fatch karne ke code

class RecipeModel {
  late String applable;
  late String appImageurl;
  late double appcalories;
  late String appurl;
  late String appShareurl;

  RecipeModel(
      {this.appImageurl = "url",
      this.appcalories = 0.000,
      this.appShareurl = "applink",
      this.applable = "label",
      this.appurl = "appurl"});
  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      appImageurl: recipe["image"],
      appShareurl: recipe["shareAs"],
      appcalories: recipe["calories"],
      applable: recipe["label"],
      appurl: recipe["url"]

    );
  }
}
