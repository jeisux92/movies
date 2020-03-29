class Cast {
  List<Actor> actors = [];

  Cast.fromJsonMap(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    actors = jsonList.map((item) => Actor.fromJson(item)).toList();
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJson(Map<String, dynamic> json) {
    this.castId = json['cast_id'];
    this.character = json['character'];
    this.creditId = json['credit_id'];
    this.gender = json['gender'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.profilePath = json['profile_path'];
  }

  get getPhoto {
    if (profilePath == null) {
      return "https://marcelloreal.com/public/system/eXfkOOiYH-uoddxClSi52viuasTF1mJ8olZ0u-tOtfFqK66gZCc90Ly_Uoc0VmR1eULwQ0uGf2JhPt4yPTts8A/themes/base/assets/images/avatar-1.png";
    }
    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}
