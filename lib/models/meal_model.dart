// class Meal {
//   final int id;
//   final String title;
//   final String imageUrl;
//
//   Meal({
//     required this.id,
//     required this.title,
//     required this.imageUrl,
//   });
//
//   factory Meal.fromMap(Map<String, dynamic> map) {
//     return Meal(
//       id: map['id'],
//       title: map['title'],
//       imageUrl: 'https://spoonacular.com/recipeImages/' + map['image'],
//     );
//   }
// }

class Meal {
  int? id;
  String? imageUrl;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;

  Meal(
      {this.id,
      this.imageUrl,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl});

  Meal.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }
}
