// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartResponse {

@JsonKey(name: 'cartId') String? get cartId;@JsonKey(name: 'cartItems') List<CartItemModel> get cartItems;
/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartResponseCopyWith<CartResponse> get copyWith => _$CartResponseCopyWithImpl<CartResponse>(this as CartResponse, _$identity);

  /// Serializes this CartResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartResponse&&(identical(other.cartId, cartId) || other.cartId == cartId)&&const DeepCollectionEquality().equals(other.cartItems, cartItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cartId,const DeepCollectionEquality().hash(cartItems));

@override
String toString() {
  return 'CartResponse(cartId: $cartId, cartItems: $cartItems)';
}


}

/// @nodoc
abstract mixin class $CartResponseCopyWith<$Res>  {
  factory $CartResponseCopyWith(CartResponse value, $Res Function(CartResponse) _then) = _$CartResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cartId') String? cartId,@JsonKey(name: 'cartItems') List<CartItemModel> cartItems
});




}
/// @nodoc
class _$CartResponseCopyWithImpl<$Res>
    implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._self, this._then);

  final CartResponse _self;
  final $Res Function(CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cartId = freezed,Object? cartItems = null,}) {
  return _then(_self.copyWith(
cartId: freezed == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String?,cartItems: null == cartItems ? _self.cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CartResponse].
extension CartResponsePatterns on CartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartResponse value)  $default,){
final _that = this;
switch (_that) {
case _CartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cartId')  String? cartId, @JsonKey(name: 'cartItems')  List<CartItemModel> cartItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.cartId,_that.cartItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cartId')  String? cartId, @JsonKey(name: 'cartItems')  List<CartItemModel> cartItems)  $default,) {final _that = this;
switch (_that) {
case _CartResponse():
return $default(_that.cartId,_that.cartItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cartId')  String? cartId, @JsonKey(name: 'cartItems')  List<CartItemModel> cartItems)?  $default,) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.cartId,_that.cartItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartResponse extends CartResponse {
  const _CartResponse({@JsonKey(name: 'cartId') this.cartId, @JsonKey(name: 'cartItems') final  List<CartItemModel> cartItems = const []}): _cartItems = cartItems,super._();
  factory _CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);

@override@JsonKey(name: 'cartId') final  String? cartId;
 final  List<CartItemModel> _cartItems;
@override@JsonKey(name: 'cartItems') List<CartItemModel> get cartItems {
  if (_cartItems is EqualUnmodifiableListView) return _cartItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cartItems);
}


/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartResponseCopyWith<_CartResponse> get copyWith => __$CartResponseCopyWithImpl<_CartResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartResponse&&(identical(other.cartId, cartId) || other.cartId == cartId)&&const DeepCollectionEquality().equals(other._cartItems, _cartItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cartId,const DeepCollectionEquality().hash(_cartItems));

@override
String toString() {
  return 'CartResponse(cartId: $cartId, cartItems: $cartItems)';
}


}

/// @nodoc
abstract mixin class _$CartResponseCopyWith<$Res> implements $CartResponseCopyWith<$Res> {
  factory _$CartResponseCopyWith(_CartResponse value, $Res Function(_CartResponse) _then) = __$CartResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cartId') String? cartId,@JsonKey(name: 'cartItems') List<CartItemModel> cartItems
});




}
/// @nodoc
class __$CartResponseCopyWithImpl<$Res>
    implements _$CartResponseCopyWith<$Res> {
  __$CartResponseCopyWithImpl(this._self, this._then);

  final _CartResponse _self;
  final $Res Function(_CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cartId = freezed,Object? cartItems = null,}) {
  return _then(_CartResponse(
cartId: freezed == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String?,cartItems: null == cartItems ? _self._cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,
  ));
}


}


/// @nodoc
mixin _$CartItemModel {

@JsonKey(name: 'itemId') String get itemId;@JsonKey(name: 'productId') String? get productId;@JsonKey(name: 'productName') String? get productName;@JsonKey(name: 'productCoverUrl') String? get productCoverUrl;@JsonKey(name: 'productStock') int? get productStock;@JsonKey(name: 'quantity') int get quantity;@JsonKey(name: 'discountPercentage') double? get discountPercentage;@JsonKey(name: 'basePricePerUnit') double? get basePricePerUnit;@JsonKey(name: 'finalPricePerUnit') double? get finalPricePerUnit;@JsonKey(name: 'totalPrice') double? get totalPrice;
/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemModelCopyWith<CartItemModel> get copyWith => _$CartItemModelCopyWithImpl<CartItemModel>(this as CartItemModel, _$identity);

  /// Serializes this CartItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemModel&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productCoverUrl, productCoverUrl) || other.productCoverUrl == productCoverUrl)&&(identical(other.productStock, productStock) || other.productStock == productStock)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.basePricePerUnit, basePricePerUnit) || other.basePricePerUnit == basePricePerUnit)&&(identical(other.finalPricePerUnit, finalPricePerUnit) || other.finalPricePerUnit == finalPricePerUnit)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,productId,productName,productCoverUrl,productStock,quantity,discountPercentage,basePricePerUnit,finalPricePerUnit,totalPrice);

@override
String toString() {
  return 'CartItemModel(itemId: $itemId, productId: $productId, productName: $productName, productCoverUrl: $productCoverUrl, productStock: $productStock, quantity: $quantity, discountPercentage: $discountPercentage, basePricePerUnit: $basePricePerUnit, finalPricePerUnit: $finalPricePerUnit, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class $CartItemModelCopyWith<$Res>  {
  factory $CartItemModelCopyWith(CartItemModel value, $Res Function(CartItemModel) _then) = _$CartItemModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'itemId') String itemId,@JsonKey(name: 'productId') String? productId,@JsonKey(name: 'productName') String? productName,@JsonKey(name: 'productCoverUrl') String? productCoverUrl,@JsonKey(name: 'productStock') int? productStock,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'discountPercentage') double? discountPercentage,@JsonKey(name: 'basePricePerUnit') double? basePricePerUnit,@JsonKey(name: 'finalPricePerUnit') double? finalPricePerUnit,@JsonKey(name: 'totalPrice') double? totalPrice
});




}
/// @nodoc
class _$CartItemModelCopyWithImpl<$Res>
    implements $CartItemModelCopyWith<$Res> {
  _$CartItemModelCopyWithImpl(this._self, this._then);

  final CartItemModel _self;
  final $Res Function(CartItemModel) _then;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? productId = freezed,Object? productName = freezed,Object? productCoverUrl = freezed,Object? productStock = freezed,Object? quantity = null,Object? discountPercentage = freezed,Object? basePricePerUnit = freezed,Object? finalPricePerUnit = freezed,Object? totalPrice = freezed,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productCoverUrl: freezed == productCoverUrl ? _self.productCoverUrl : productCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,productStock: freezed == productStock ? _self.productStock : productStock // ignore: cast_nullable_to_non_nullable
as int?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,basePricePerUnit: freezed == basePricePerUnit ? _self.basePricePerUnit : basePricePerUnit // ignore: cast_nullable_to_non_nullable
as double?,finalPricePerUnit: freezed == finalPricePerUnit ? _self.finalPricePerUnit : finalPricePerUnit // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemModel].
extension CartItemModelPatterns on CartItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemModel value)  $default,){
final _that = this;
switch (_that) {
case _CartItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'itemId')  String itemId, @JsonKey(name: 'productId')  String? productId, @JsonKey(name: 'productName')  String? productName, @JsonKey(name: 'productCoverUrl')  String? productCoverUrl, @JsonKey(name: 'productStock')  int? productStock, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'basePricePerUnit')  double? basePricePerUnit, @JsonKey(name: 'finalPricePerUnit')  double? finalPricePerUnit, @JsonKey(name: 'totalPrice')  double? totalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
return $default(_that.itemId,_that.productId,_that.productName,_that.productCoverUrl,_that.productStock,_that.quantity,_that.discountPercentage,_that.basePricePerUnit,_that.finalPricePerUnit,_that.totalPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'itemId')  String itemId, @JsonKey(name: 'productId')  String? productId, @JsonKey(name: 'productName')  String? productName, @JsonKey(name: 'productCoverUrl')  String? productCoverUrl, @JsonKey(name: 'productStock')  int? productStock, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'basePricePerUnit')  double? basePricePerUnit, @JsonKey(name: 'finalPricePerUnit')  double? finalPricePerUnit, @JsonKey(name: 'totalPrice')  double? totalPrice)  $default,) {final _that = this;
switch (_that) {
case _CartItemModel():
return $default(_that.itemId,_that.productId,_that.productName,_that.productCoverUrl,_that.productStock,_that.quantity,_that.discountPercentage,_that.basePricePerUnit,_that.finalPricePerUnit,_that.totalPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'itemId')  String itemId, @JsonKey(name: 'productId')  String? productId, @JsonKey(name: 'productName')  String? productName, @JsonKey(name: 'productCoverUrl')  String? productCoverUrl, @JsonKey(name: 'productStock')  int? productStock, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'discountPercentage')  double? discountPercentage, @JsonKey(name: 'basePricePerUnit')  double? basePricePerUnit, @JsonKey(name: 'finalPricePerUnit')  double? finalPricePerUnit, @JsonKey(name: 'totalPrice')  double? totalPrice)?  $default,) {final _that = this;
switch (_that) {
case _CartItemModel() when $default != null:
return $default(_that.itemId,_that.productId,_that.productName,_that.productCoverUrl,_that.productStock,_that.quantity,_that.discountPercentage,_that.basePricePerUnit,_that.finalPricePerUnit,_that.totalPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemModel implements CartItemModel {
  const _CartItemModel({@JsonKey(name: 'itemId') required this.itemId, @JsonKey(name: 'productId') this.productId, @JsonKey(name: 'productName') this.productName, @JsonKey(name: 'productCoverUrl') this.productCoverUrl, @JsonKey(name: 'productStock') this.productStock, @JsonKey(name: 'quantity') this.quantity = 1, @JsonKey(name: 'discountPercentage') this.discountPercentage, @JsonKey(name: 'basePricePerUnit') this.basePricePerUnit, @JsonKey(name: 'finalPricePerUnit') this.finalPricePerUnit, @JsonKey(name: 'totalPrice') this.totalPrice});
  factory _CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

@override@JsonKey(name: 'itemId') final  String itemId;
@override@JsonKey(name: 'productId') final  String? productId;
@override@JsonKey(name: 'productName') final  String? productName;
@override@JsonKey(name: 'productCoverUrl') final  String? productCoverUrl;
@override@JsonKey(name: 'productStock') final  int? productStock;
@override@JsonKey(name: 'quantity') final  int quantity;
@override@JsonKey(name: 'discountPercentage') final  double? discountPercentage;
@override@JsonKey(name: 'basePricePerUnit') final  double? basePricePerUnit;
@override@JsonKey(name: 'finalPricePerUnit') final  double? finalPricePerUnit;
@override@JsonKey(name: 'totalPrice') final  double? totalPrice;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemModelCopyWith<_CartItemModel> get copyWith => __$CartItemModelCopyWithImpl<_CartItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemModel&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productCoverUrl, productCoverUrl) || other.productCoverUrl == productCoverUrl)&&(identical(other.productStock, productStock) || other.productStock == productStock)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.basePricePerUnit, basePricePerUnit) || other.basePricePerUnit == basePricePerUnit)&&(identical(other.finalPricePerUnit, finalPricePerUnit) || other.finalPricePerUnit == finalPricePerUnit)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,productId,productName,productCoverUrl,productStock,quantity,discountPercentage,basePricePerUnit,finalPricePerUnit,totalPrice);

@override
String toString() {
  return 'CartItemModel(itemId: $itemId, productId: $productId, productName: $productName, productCoverUrl: $productCoverUrl, productStock: $productStock, quantity: $quantity, discountPercentage: $discountPercentage, basePricePerUnit: $basePricePerUnit, finalPricePerUnit: $finalPricePerUnit, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class _$CartItemModelCopyWith<$Res> implements $CartItemModelCopyWith<$Res> {
  factory _$CartItemModelCopyWith(_CartItemModel value, $Res Function(_CartItemModel) _then) = __$CartItemModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'itemId') String itemId,@JsonKey(name: 'productId') String? productId,@JsonKey(name: 'productName') String? productName,@JsonKey(name: 'productCoverUrl') String? productCoverUrl,@JsonKey(name: 'productStock') int? productStock,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'discountPercentage') double? discountPercentage,@JsonKey(name: 'basePricePerUnit') double? basePricePerUnit,@JsonKey(name: 'finalPricePerUnit') double? finalPricePerUnit,@JsonKey(name: 'totalPrice') double? totalPrice
});




}
/// @nodoc
class __$CartItemModelCopyWithImpl<$Res>
    implements _$CartItemModelCopyWith<$Res> {
  __$CartItemModelCopyWithImpl(this._self, this._then);

  final _CartItemModel _self;
  final $Res Function(_CartItemModel) _then;

/// Create a copy of CartItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? productId = freezed,Object? productName = freezed,Object? productCoverUrl = freezed,Object? productStock = freezed,Object? quantity = null,Object? discountPercentage = freezed,Object? basePricePerUnit = freezed,Object? finalPricePerUnit = freezed,Object? totalPrice = freezed,}) {
  return _then(_CartItemModel(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productCoverUrl: freezed == productCoverUrl ? _self.productCoverUrl : productCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,productStock: freezed == productStock ? _self.productStock : productStock // ignore: cast_nullable_to_non_nullable
as int?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,basePricePerUnit: freezed == basePricePerUnit ? _self.basePricePerUnit : basePricePerUnit // ignore: cast_nullable_to_non_nullable
as double?,finalPricePerUnit: freezed == finalPricePerUnit ? _self.finalPricePerUnit : finalPricePerUnit // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
