class CategoryModel {
  String id;
  String title;
  String imagePath;

  CategoryModel(
      {required this.id, required this.imagePath, required this.title});
//business entertainment general health science sports technology
  static List<CategoryModel> getCategoryList(bool isDark) {
    return [
      CategoryModel(
          id: "general",
          imagePath: !isDark
              ? "assets/images/GeneralDark.png"
              : "assets/images/GeneralLight.png",
          title: "General"),
      CategoryModel(
          id: "business",
          imagePath: !isDark
              ? "assets/images/BusinessDark.png"
              : "assets/images/BusinessLight.png",
          title: "Business"),
      CategoryModel(
          id: "sports",
          imagePath: !isDark
              ? "assets/images/SportDark.png"
              : "assets/images/SportLight.png",
          title: "Sports"),
      CategoryModel(
          id: "technology",
          imagePath: !isDark
              ? "assets/images/TechnologyDark.png"
              : "assets/images/TechnologyLight.png",
          title: "Technology"),
      CategoryModel(
          id: "entertainment",
          imagePath: !isDark
              ? "assets/images/EntertainmentDark.png"
              : "assets/images/EntertainmentLight.png",
          title: "Entertainment"),
      CategoryModel(
          id: "health",
          imagePath: !isDark
              ? "assets/images/HealthDark.png"
              : "assets/images/HealthLight.png",
          title: "Health"),
      CategoryModel(
          id: "science",
          imagePath: !isDark
              ? "assets/images/ScienceDark.png"
              : "assets/images/ScienceLight.png",
          title: "Science"),
    ];
  }
}
