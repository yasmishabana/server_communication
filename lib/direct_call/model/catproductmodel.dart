class CategoryProductModel {
    final String productId;
    final String id;
    final String title;
    final String description;
    final String image;

    CategoryProductModel({
        required this.productId,
        required this.id,
        required this.title,
        required this.description,
        required this.image,
    });

    factory CategoryProductModel.fromJson(Map<String, dynamic> json) {
      
      return CategoryProductModel(
        productId: json["Product_id"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
    );
    }
    // Map<String, dynamic> toJson() => {
    //     "Product_id": productId,
    //     "id": id,
    //     "title": title,
    //     "description": description,
    //     "image": image,
    // };
}
