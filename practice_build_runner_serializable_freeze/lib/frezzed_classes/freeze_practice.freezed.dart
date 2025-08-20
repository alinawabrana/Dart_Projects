// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freeze_practice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InfoObjectFreezed {

 String get id; String get name; DataFreezed get data;
/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoObjectFreezedCopyWith<InfoObjectFreezed> get copyWith => _$InfoObjectFreezedCopyWithImpl<InfoObjectFreezed>(this as InfoObjectFreezed, _$identity);

  /// Serializes this InfoObjectFreezed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoObjectFreezed&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,data);

@override
String toString() {
  return 'InfoObjectFreezed(id: $id, name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class $InfoObjectFreezedCopyWith<$Res>  {
  factory $InfoObjectFreezedCopyWith(InfoObjectFreezed value, $Res Function(InfoObjectFreezed) _then) = _$InfoObjectFreezedCopyWithImpl;
@useResult
$Res call({
 String id, String name, DataFreezed data
});


$DataFreezedCopyWith<$Res> get data;

}
/// @nodoc
class _$InfoObjectFreezedCopyWithImpl<$Res>
    implements $InfoObjectFreezedCopyWith<$Res> {
  _$InfoObjectFreezedCopyWithImpl(this._self, this._then);

  final InfoObjectFreezed _self;
  final $Res Function(InfoObjectFreezed) _then;

/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? data = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataFreezed,
  ));
}
/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataFreezedCopyWith<$Res> get data {
  
  return $DataFreezedCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [InfoObjectFreezed].
extension InfoObjectFreezedPatterns on InfoObjectFreezed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoObjectFreezed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoObjectFreezed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoObjectFreezed value)  $default,){
final _that = this;
switch (_that) {
case _InfoObjectFreezed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoObjectFreezed value)?  $default,){
final _that = this;
switch (_that) {
case _InfoObjectFreezed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DataFreezed data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoObjectFreezed() when $default != null:
return $default(_that.id,_that.name,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DataFreezed data)  $default,) {final _that = this;
switch (_that) {
case _InfoObjectFreezed():
return $default(_that.id,_that.name,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DataFreezed data)?  $default,) {final _that = this;
switch (_that) {
case _InfoObjectFreezed() when $default != null:
return $default(_that.id,_that.name,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InfoObjectFreezed implements InfoObjectFreezed {
  const _InfoObjectFreezed({required this.id, required this.name, required this.data});
  factory _InfoObjectFreezed.fromJson(Map<String, dynamic> json) => _$InfoObjectFreezedFromJson(json);

@override final  String id;
@override final  String name;
@override final  DataFreezed data;

/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoObjectFreezedCopyWith<_InfoObjectFreezed> get copyWith => __$InfoObjectFreezedCopyWithImpl<_InfoObjectFreezed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InfoObjectFreezedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoObjectFreezed&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,data);

@override
String toString() {
  return 'InfoObjectFreezed(id: $id, name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class _$InfoObjectFreezedCopyWith<$Res> implements $InfoObjectFreezedCopyWith<$Res> {
  factory _$InfoObjectFreezedCopyWith(_InfoObjectFreezed value, $Res Function(_InfoObjectFreezed) _then) = __$InfoObjectFreezedCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DataFreezed data
});


@override $DataFreezedCopyWith<$Res> get data;

}
/// @nodoc
class __$InfoObjectFreezedCopyWithImpl<$Res>
    implements _$InfoObjectFreezedCopyWith<$Res> {
  __$InfoObjectFreezedCopyWithImpl(this._self, this._then);

  final _InfoObjectFreezed _self;
  final $Res Function(_InfoObjectFreezed) _then;

/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? data = null,}) {
  return _then(_InfoObjectFreezed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataFreezed,
  ));
}

/// Create a copy of InfoObjectFreezed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataFreezedCopyWith<$Res> get data {
  
  return $DataFreezedCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$DataFreezed {

 int get year; double get price;@JsonKey(name: 'CPU model') String get cpuModel;@JsonKey(name: 'Hard disk size') String get hardDiskSize;
/// Create a copy of DataFreezed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataFreezedCopyWith<DataFreezed> get copyWith => _$DataFreezedCopyWithImpl<DataFreezed>(this as DataFreezed, _$identity);

  /// Serializes this DataFreezed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataFreezed&&(identical(other.year, year) || other.year == year)&&(identical(other.price, price) || other.price == price)&&(identical(other.cpuModel, cpuModel) || other.cpuModel == cpuModel)&&(identical(other.hardDiskSize, hardDiskSize) || other.hardDiskSize == hardDiskSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,price,cpuModel,hardDiskSize);

@override
String toString() {
  return 'DataFreezed(year: $year, price: $price, cpuModel: $cpuModel, hardDiskSize: $hardDiskSize)';
}


}

/// @nodoc
abstract mixin class $DataFreezedCopyWith<$Res>  {
  factory $DataFreezedCopyWith(DataFreezed value, $Res Function(DataFreezed) _then) = _$DataFreezedCopyWithImpl;
@useResult
$Res call({
 int year, double price,@JsonKey(name: 'CPU model') String cpuModel,@JsonKey(name: 'Hard disk size') String hardDiskSize
});




}
/// @nodoc
class _$DataFreezedCopyWithImpl<$Res>
    implements $DataFreezedCopyWith<$Res> {
  _$DataFreezedCopyWithImpl(this._self, this._then);

  final DataFreezed _self;
  final $Res Function(DataFreezed) _then;

/// Create a copy of DataFreezed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? price = null,Object? cpuModel = null,Object? hardDiskSize = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,cpuModel: null == cpuModel ? _self.cpuModel : cpuModel // ignore: cast_nullable_to_non_nullable
as String,hardDiskSize: null == hardDiskSize ? _self.hardDiskSize : hardDiskSize // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DataFreezed].
extension DataFreezedPatterns on DataFreezed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DataFreezed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DataFreezed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DataFreezed value)  $default,){
final _that = this;
switch (_that) {
case _DataFreezed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DataFreezed value)?  $default,){
final _that = this;
switch (_that) {
case _DataFreezed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  double price, @JsonKey(name: 'CPU model')  String cpuModel, @JsonKey(name: 'Hard disk size')  String hardDiskSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DataFreezed() when $default != null:
return $default(_that.year,_that.price,_that.cpuModel,_that.hardDiskSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  double price, @JsonKey(name: 'CPU model')  String cpuModel, @JsonKey(name: 'Hard disk size')  String hardDiskSize)  $default,) {final _that = this;
switch (_that) {
case _DataFreezed():
return $default(_that.year,_that.price,_that.cpuModel,_that.hardDiskSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  double price, @JsonKey(name: 'CPU model')  String cpuModel, @JsonKey(name: 'Hard disk size')  String hardDiskSize)?  $default,) {final _that = this;
switch (_that) {
case _DataFreezed() when $default != null:
return $default(_that.year,_that.price,_that.cpuModel,_that.hardDiskSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DataFreezed implements DataFreezed {
  const _DataFreezed({required this.year, required this.price, @JsonKey(name: 'CPU model') required this.cpuModel, @JsonKey(name: 'Hard disk size') required this.hardDiskSize});
  factory _DataFreezed.fromJson(Map<String, dynamic> json) => _$DataFreezedFromJson(json);

@override final  int year;
@override final  double price;
@override@JsonKey(name: 'CPU model') final  String cpuModel;
@override@JsonKey(name: 'Hard disk size') final  String hardDiskSize;

/// Create a copy of DataFreezed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataFreezedCopyWith<_DataFreezed> get copyWith => __$DataFreezedCopyWithImpl<_DataFreezed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataFreezedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataFreezed&&(identical(other.year, year) || other.year == year)&&(identical(other.price, price) || other.price == price)&&(identical(other.cpuModel, cpuModel) || other.cpuModel == cpuModel)&&(identical(other.hardDiskSize, hardDiskSize) || other.hardDiskSize == hardDiskSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,price,cpuModel,hardDiskSize);

@override
String toString() {
  return 'DataFreezed(year: $year, price: $price, cpuModel: $cpuModel, hardDiskSize: $hardDiskSize)';
}


}

/// @nodoc
abstract mixin class _$DataFreezedCopyWith<$Res> implements $DataFreezedCopyWith<$Res> {
  factory _$DataFreezedCopyWith(_DataFreezed value, $Res Function(_DataFreezed) _then) = __$DataFreezedCopyWithImpl;
@override @useResult
$Res call({
 int year, double price,@JsonKey(name: 'CPU model') String cpuModel,@JsonKey(name: 'Hard disk size') String hardDiskSize
});




}
/// @nodoc
class __$DataFreezedCopyWithImpl<$Res>
    implements _$DataFreezedCopyWith<$Res> {
  __$DataFreezedCopyWithImpl(this._self, this._then);

  final _DataFreezed _self;
  final $Res Function(_DataFreezed) _then;

/// Create a copy of DataFreezed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? price = null,Object? cpuModel = null,Object? hardDiskSize = null,}) {
  return _then(_DataFreezed(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,cpuModel: null == cpuModel ? _self.cpuModel : cpuModel // ignore: cast_nullable_to_non_nullable
as String,hardDiskSize: null == hardDiskSize ? _self.hardDiskSize : hardDiskSize // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Person {

 String get name; int? get age;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'Person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 String name, int? age
});




}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int? age)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.name,_that.age);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int? age)  $default,) {final _that = this;
switch (_that) {
case _Person():
return $default(_that.name,_that.age);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int? age)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.name,_that.age);case _:
  return null;

}
}

}

/// @nodoc


class _Person extends Person {
  const _Person(this.name, {this.age}): super._();
  

@override final  String name;
@override final  int? age;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age));
}


@override
int get hashCode => Object.hash(runtimeType,name,age);

@override
String toString() {
  return 'Person(name: $name, age: $age)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 String name, int? age
});




}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = freezed,}) {
  return _then(_Person(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
