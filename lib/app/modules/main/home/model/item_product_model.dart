class ItemProductModel {
  final String? id;
  final String? code;
  final ItemProductInfo? itemProductInfo;
  final int? quantity;
  final double? priceOriginal;
  final double? priceRegular;
  final ItemProductAttributes? itemProductAttributes;
  final List<String>? itemProductCategories;
  final String? image;
  final String? stocks;
  final String? status;
  final String? visibility;
  final String? author;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final List<ItemProductReviews>? itemProductReviews;

  ItemProductModel({
    this.id,
    this.code,
    this.itemProductInfo,
    this.quantity,
    this.priceOriginal,
    this.priceRegular,
    this.itemProductAttributes,
    this.itemProductCategories,
    this.image,
    this.stocks,
    this.status,
    this.visibility,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.itemProductReviews,
  });

  ItemProductModel copyWith({
    String? id,
    String? code,
    ItemProductInfo? itemProductInfo,
    int? quantity,
    double? priceOriginal,
    double? priceRegular,
    ItemProductAttributes? itemProductAttributes,
    List<String>? itemProductCategories,
    String? image,
    String? stocks,
    String? status,
    String? visibility,
    String? author,
    String? createdAt,
    String? updatedAt,
    int? v,
    List<ItemProductReviews>? itemProductReviews,
  }) {
    return ItemProductModel(
      id: id ?? this.id,
      code: code ?? this.code,
      itemProductInfo: itemProductInfo ?? this.itemProductInfo,
      quantity: quantity ?? this.quantity,
      priceOriginal: priceOriginal ?? this.priceOriginal,
      priceRegular: priceRegular ?? this.priceRegular,
      itemProductAttributes:
      itemProductAttributes ?? this.itemProductAttributes,
      itemProductCategories:
      itemProductCategories ?? this.itemProductCategories,
      image: image ?? this.image,
      stocks: stocks ?? this.stocks,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      itemProductReviews: itemProductReviews ?? this.itemProductReviews,
    );
  }

  ItemProductModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        code = json['code'] as String?,
        itemProductInfo = (json['info'] as Map<String, dynamic>?) != null
            ? ItemProductInfo.fromJson(json['info'] as Map<String, dynamic>)
            : null,
        quantity = json['quantity'] as int?,
        priceOriginal = json['priceOriginal'] != null
            ? (json['priceOriginal'] as num).toDouble()
            : 0,
        priceRegular = json['priceRegular'] != null
            ? (json['priceRegular'] as num).toDouble()
            : 0,
        itemProductAttributes =
        (json['attributes'] as Map<String, dynamic>?) != null
            ? ItemProductAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>)
            : null,
        itemProductCategories = (json['categories'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        image = json['image'] as String?,
        stocks = json['stocks'] as String?,
        status = json['status'] as String?,
        visibility = json['visibility'] as String?,
        author = json['author'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        itemProductReviews = (json['reviews'] as List?)
            ?.map((dynamic e) =>
            ItemProductReviews.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    '_id': id,
    'code': code,
    'info': itemProductInfo?.toJson(),
    'quantity': quantity,
    'priceOriginal': priceOriginal,
    'priceRegular': priceRegular,
    'attributes': itemProductAttributes?.toJson(),
    'categories': itemProductCategories,
    'image': image,
    'stocks': stocks,
    'status': status,
    'visibility': visibility,
    'author': author,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'reviews': itemProductReviews?.map((e) => e.toJson()).toList()
  };
}

class ItemProductInfo {
  final ItemProductInfoVi? itemProductInfoVi;
  final ItemProductInfoEn? itemProductInfoEn;

  ItemProductInfo({
    this.itemProductInfoVi,
    this.itemProductInfoEn,
  });

  ItemProductInfo copyWith({
    ItemProductInfoVi? itemProductInfoVi,
    ItemProductInfoEn? itemProductInfoEn,
  }) {
    return ItemProductInfo(
      itemProductInfoVi: itemProductInfoVi ?? this.itemProductInfoVi,
      itemProductInfoEn: itemProductInfoEn ?? this.itemProductInfoEn,
    );
  }

  ItemProductInfo.fromJson(Map<String, dynamic> json)
      : itemProductInfoVi = (json['vi'] as Map<String, dynamic>?) != null
      ? ItemProductInfoVi.fromJson(json['vi'] as Map<String, dynamic>)
      : null,
        itemProductInfoEn = (json['en'] as Map<String, dynamic>?) != null
            ? ItemProductInfoEn.fromJson(json['en'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'vi': itemProductInfoVi?.toJson(), 'en': itemProductInfoEn?.toJson()};
}

class ItemProductInfoVi {
  final String? name;
  final String? description;
  final String? content;
  final String? slug;

  ItemProductInfoVi({
    this.name,
    this.description,
    this.content,
    this.slug,
  });

  ItemProductInfoVi copyWith({
    String? name,
    String? description,
    String? content,
    String? slug,
  }) {
    return ItemProductInfoVi(
      name: name ?? this.name,
      description: description ?? this.description,
      content: content ?? this.content,
      slug: slug ?? this.slug,
    );
  }

  ItemProductInfoVi.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        description = json['description'] as String?,
        content = json['content'] as String?,
        slug = json['slug'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'content': content,
    'slug': slug
  };
}

class ItemProductInfoEn {
  final String? name;
  final String? description;
  final String? content;
  final String? slug;

  ItemProductInfoEn({
    this.name,
    this.description,
    this.content,
    this.slug,
  });

  ItemProductInfoEn copyWith({
    String? name,
    String? description,
    String? content,
    String? slug,
  }) {
    return ItemProductInfoEn(
      name: name ?? this.name,
      description: description ?? this.description,
      content: content ?? this.content,
      slug: slug ?? this.slug,
    );
  }

  ItemProductInfoEn.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        description = json['description'] as String?,
        content = json['content'] as String?,
        slug = json['slug'] as String?;

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'content': content,
    'slug': slug
  };
}

class ItemProductAttributes {
  final List<ItemProductAttributesSize>? itemProductAttributesSize;
  final List<ItemProductAttributesColor>? itemProductAttributesColor;

  ItemProductAttributes({
    this.itemProductAttributesSize,
    this.itemProductAttributesColor,
  });

  ItemProductAttributes copyWith({
    List<ItemProductAttributesSize>? itemProductAttributesSize,
    List<ItemProductAttributesColor>? itemProductAttributesColor,
  }) {
    return ItemProductAttributes(
      itemProductAttributesSize:
      itemProductAttributesSize ?? this.itemProductAttributesSize,
      itemProductAttributesColor:
      itemProductAttributesColor ?? this.itemProductAttributesColor,
    );
  }

  ItemProductAttributes.fromJson(Map<String, dynamic> json)
      : itemProductAttributesSize = (json['size'] as List?)
      ?.map((dynamic e) =>
      ItemProductAttributesSize.fromJson(e as Map<String, dynamic>))
      .toList(),
        itemProductAttributesColor = (json['color'] as List?)
            ?.map((dynamic e) =>
            ItemProductAttributesColor.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    'size': itemProductAttributesSize?.map((e) => e.toJson()).toList(),
    'color': itemProductAttributesColor?.map((e) => e.toJson()).toList()
  };
}

class ItemProductAttributesSize {
  final String? name;
  final String? value;

  ItemProductAttributesSize({
    this.name,
    this.value,
  });

  ItemProductAttributesSize copyWith({
    String? name,
    String? value,
  }) {
    return ItemProductAttributesSize(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  ItemProductAttributesSize.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        value = json['value'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class ItemProductAttributesColor {
  final String? name;
  final String? value;

  ItemProductAttributesColor({
    this.name,
    this.value,
  });

  ItemProductAttributesColor copyWith({
    String? name,
    String? value,
  }) {
    return ItemProductAttributesColor(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  ItemProductAttributesColor.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        value = json['value'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class ItemProductReviews {
  final String? id;
  final int? totalRating;
  final double? averageRating;
  final int? countRating;

  ItemProductReviews({
    this.id,
    this.totalRating,
    this.averageRating,
    this.countRating,
  });

  ItemProductReviews copyWith({
    String? id,
    int? totalRating,
    double? averageRating,
    int? countRating,
  }) {
    return ItemProductReviews(
      id: id ?? this.id,
      totalRating: totalRating ?? this.totalRating,
      averageRating: averageRating ?? this.averageRating,
      countRating: countRating ?? this.countRating,
    );
  }

  ItemProductReviews.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        totalRating = json['totalRating'] as int?,
        averageRating = (json['averageRating'] as num).toDouble(),
        countRating = json['countRating'] as int?;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'totalRating': totalRating,
    'averageRating': averageRating,
    'countRating': countRating
  };
}
