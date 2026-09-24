// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductsResponse {

 List<ProductModel> get items; int get page; int get pageSize; int get totalCount; bool get hasNextPage;
/// Create a copy of ProductsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsResponseCopyWith<ProductsResponse> get copyWith => _$ProductsResponseCopyWithImpl<ProductsResponse>(this as ProductsResponse, _$identity);

  /// Serializes this ProductsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,pageSize,totalCount,hasNextPage);

@override
String toString() {
  return 'ProductsResponse(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $ProductsResponseCopyWith<$Res>  {
  factory $ProductsResponseCopyWith(ProductsResponse value, $Res Function(ProductsResponse) _then) = _$ProductsResponseCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> items, int page, int pageSize, int totalCount, bool hasNextPage
});




}
/// @nodoc
class _$ProductsResponseCopyWithImpl<$Res>
    implements $ProductsResponseCopyWith<$Res> {
  _$ProductsResponseCopyWithImpl(this._self, this._then);

  final ProductsResponse _self;
  final $Res Function(ProductsResponse) _then;

/// Create a copy of ProductsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalCount = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsResponse].
extension ProductsResponsePatterns on ProductsResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProductsResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductModel> items,  int page,  int pageSize,  int totalCount,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsResponse() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.hasNextPage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductModel> items,  int page,  int pageSize,  int totalCount,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _ProductsResponse():
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.hasNextPage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductModel> items,  int page,  int pageSize,  int totalCount,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _ProductsResponse() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductsResponse implements ProductsResponse {
  const _ProductsResponse({final  List<ProductModel> items = const [], this.page = 1, this.pageSize = 0, this.totalCount = 0, this.hasNextPage = false}): _items = items;
  factory _ProductsResponse.fromJson(Map<String, dynamic> json) => _$ProductsResponseFromJson(json);

 final  List<ProductModel> _items;
@override@JsonKey() List<ProductModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool hasNextPage;

/// Create a copy of ProductsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsResponseCopyWith<_ProductsResponse> get copyWith => __$ProductsResponseCopyWithImpl<_ProductsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,pageSize,totalCount,hasNextPage);

@override
String toString() {
  return 'ProductsResponse(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$ProductsResponseCopyWith<$Res> implements $ProductsResponseCopyWith<$Res> {
  factory _$ProductsResponseCopyWith(_ProductsResponse value, $Res Function(_ProductsResponse) _then) = __$ProductsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ProductModel> items, int page, int pageSize, int totalCount, bool hasNextPage
});




}
/// @nodoc
class __$ProductsResponseCopyWithImpl<$Res>
    implements _$ProductsResponseCopyWith<$Res> {
  __$ProductsResponseCopyWithImpl(this._self, this._then);

  final _ProductsResponse _self;
  final $Res Function(_ProductsResponse) _then;

/// Create a copy of ProductsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalCount = null,Object? hasNextPage = null,}) {
  return _then(_ProductsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ProductModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'productCode') String? get productCode;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'coverPictureUrl') String? get coverPictureUrl;@JsonKey(name: 'productPictures') List<String>? get productPictures;@JsonKey(name: 'categories') List<String>? get categories;@JsonKey(name: 'price') double? get price;@JsonKey(name: 'stock') int? get stock;@JsonKey(name: 'weight') double? get weight;@JsonKey(name: 'color') String? get color;@JsonKey(name: 'discountPercentage') double? get discountPercentage;@JsonKey(name: 'rating') double? get rating;@JsonKey(name: 'reviewsCount') int? get reviewsCount;@JsonKey(name: 'sellerId') String? get sellerId;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverPictureUrl, coverPictureUrl) || other.coverPictureUrl == coverPictureUrl)&&const DeepCollectionEquality().equals(other.productPictures, productPictures)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.color, color) || other.color == color)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productCode,name,description,coverPictureUrl,const DeepCollectionEquality().hash(productPictures),const DeepCollectionEquality().hash(categories),price,stock,weight,color,discountPercentage,rating,reviewsCount,sellerId);

@override
String toString() {
  return 'ProductModel(id: $id, productCode: $productCode, name: $name, description: $description, coverPictureUrl: $coverPictureUrl, productPictures: $productPictures, categories: $categories, price: $price, stock: $stock, weight: $weight, color: $color, discountPercentage: $discountPercentage, rating: $rating, reviewsCount: $reviewsCount, sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'productCode') String? productCode,@JsonKey(name: 'name') String? name,@JsonKey(name: 'description') String? description,@JsonKey(name: 'coverPictureUrl') String? coverPictureUrl,@JsonKey(name: 'productPictures') List<String>? productPictures,@JsonKey(name: 'categories') List<String>? categories,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'weight') double? weight,@JsonKey(name: 'color') String? color,@JsonKey(name: 'discountPercentage') double? discountPercentage,@JsonKey(name: 'rating') double? rating,@JsonKey(name: 'reviewsCount') int? reviewsCount,@JsonKey(name: 'sellerId') String? sellerId
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? productCode = freezed,Object? name = freezed,Object? description = freezed,Object? coverPictureUrl = freezed,Object? productPictures = freezed,Object? categories = freezed,Object? price = freezed,Object? stock = freezed,Object? weight = freezed,Object? color = freezed,Object? discountPercentage = freezed,Object? rating = freezed,Object? reviewsCount = freezed,Object? sellerId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverPictureUrl: freezed == coverPictureUrl ? _self.coverPictureUrl : coverPictureUrl // ignore: cast_nullable_to_non_nullable
as String?,productPictures: freezed == productPictures ? _self.productPictures : productPictures // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: freezed == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int?,sellerId: freezed == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'productCode')  String? productCode, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'coverPictureUrl')  String? coverPictureUrl, @JsonKey(name: 'productPictures')  List<String>? productPictures, @JsonKey(name: 'categories')  List<String>? categories, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'weight')  double? weight, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'rating')  double? rating, @JsonKey(name: 'reviewsCount')  int? reviewsCount, @JsonKey(name: 'sellerId')  String? sellerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.productCode,_that.name,_that.description,_that.coverPictureUrl,_that.productPictures,_that.categories,_that.price,_that.stock,_that.weight,_that.color,_that.discountPercentage,_that.rating,_that.reviewsCount,_that.sellerId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'productCode')  String? productCode, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'coverPictureUrl')  String? coverPictureUrl, @JsonKey(name: 'productPictures')  List<String>? productPictures, @JsonKey(name: 'categories')  List<String>? categories, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'weight')  double? weight, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'rating')  double? rating, @JsonKey(name: 'reviewsCount')  int? reviewsCount, @JsonKey(name: 'sellerId')  String? sellerId)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.productCode,_that.name,_that.description,_that.coverPictureUrl,_that.productPictures,_that.categories,_that.price,_that.stock,_that.weight,_that.color,_that.discountPercentage,_that.rating,_that.reviewsCount,_that.sellerId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'productCode')  String? productCode, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'coverPictureUrl')  String? coverPictureUrl, @JsonKey(name: 'productPictures')  List<String>? productPictures, @JsonKey(name: 'categories')  List<String>? categories, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'weight')  double? weight, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'rating')  double? rating, @JsonKey(name: 'reviewsCount')  int? reviewsCount, @JsonKey(name: 'sellerId')  String? sellerId)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.productCode,_that.name,_that.description,_that.coverPictureUrl,_that.productPictures,_that.categories,_that.price,_that.stock,_that.weight,_that.color,_that.discountPercentage,_that.rating,_that.reviewsCount,_that.sellerId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'productCode') this.productCode, @JsonKey(name: 'name') this.name, @JsonKey(name: 'description') this.description, @JsonKey(name: 'coverPictureUrl') this.coverPictureUrl, @JsonKey(name: 'productPictures') final  List<String>? productPictures, @JsonKey(name: 'categories') final  List<String>? categories, @JsonKey(name: 'price') this.price, @JsonKey(name: 'stock') this.stock, @JsonKey(name: 'weight') this.weight, @JsonKey(name: 'color') this.color, @JsonKey(name: 'discountPercentage') this.discountPercentage, @JsonKey(name: 'rating') this.rating, @JsonKey(name: 'reviewsCount') this.reviewsCount, @JsonKey(name: 'sellerId') this.sellerId}): _productPictures = productPictures,_categories = categories,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'productCode') final  String? productCode;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'coverPictureUrl') final  String? coverPictureUrl;
 final  List<String>? _productPictures;
@override@JsonKey(name: 'productPictures') List<String>? get productPictures {
  final value = _productPictures;
  if (value == null) return null;
  if (_productPictures is EqualUnmodifiableListView) return _productPictures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _categories;
@override@JsonKey(name: 'categories') List<String>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'price') final  double? price;
@override@JsonKey(name: 'stock') final  int? stock;
@override@JsonKey(name: 'weight') final  double? weight;
@override@JsonKey(name: 'color') final  String? color;
@override@JsonKey(name: 'discountPercentage') final  double? discountPercentage;
@override@JsonKey(name: 'rating') final  double? rating;
@override@JsonKey(name: 'reviewsCount') final  int? reviewsCount;
@override@JsonKey(name: 'sellerId') final  String? sellerId;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverPictureUrl, coverPictureUrl) || other.coverPictureUrl == coverPictureUrl)&&const DeepCollectionEquality().equals(other._productPictures, _productPictures)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.color, color) || other.color == color)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productCode,name,description,coverPictureUrl,const DeepCollectionEquality().hash(_productPictures),const DeepCollectionEquality().hash(_categories),price,stock,weight,color,discountPercentage,rating,reviewsCount,sellerId);

@override
String toString() {
  return 'ProductModel(id: $id, productCode: $productCode, name: $name, description: $description, coverPictureUrl: $coverPictureUrl, productPictures: $productPictures, categories: $categories, price: $price, stock: $stock, weight: $weight, color: $color, discountPercentage: $discountPercentage, rating: $rating, reviewsCount: $reviewsCount, sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'productCode') String? productCode,@JsonKey(name: 'name') String? name,@JsonKey(name: 'description') String? description,@JsonKey(name: 'coverPictureUrl') String? coverPictureUrl,@JsonKey(name: 'productPictures') List<String>? productPictures,@JsonKey(name: 'categories') List<String>? categories,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'weight') double? weight,@JsonKey(name: 'color') String? color,@JsonKey(name: 'discountPercentage') double? discountPercentage,@JsonKey(name: 'rating') double? rating,@JsonKey(name: 'reviewsCount') int? reviewsCount,@JsonKey(name: 'sellerId') String? sellerId
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? productCode = freezed,Object? name = freezed,Object? description = freezed,Object? coverPictureUrl = freezed,Object? productPictures = freezed,Object? categories = freezed,Object? price = freezed,Object? stock = freezed,Object? weight = freezed,Object? color = freezed,Object? discountPercentage = freezed,Object? rating = freezed,Object? reviewsCount = freezed,Object? sellerId = freezed,}) {
  return _then(_ProductModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverPictureUrl: freezed == coverPictureUrl ? _self.coverPictureUrl : coverPictureUrl // ignore: cast_nullable_to_non_nullable
as String?,productPictures: freezed == productPictures ? _self._productPictures : productPictures // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: freezed == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int?,sellerId: freezed == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
