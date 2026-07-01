// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_bill_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OwnerBillEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerBillEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerBillEvent()';
}


}

/// @nodoc
class $OwnerBillEventCopyWith<$Res>  {
$OwnerBillEventCopyWith(OwnerBillEvent _, $Res Function(OwnerBillEvent) __);
}


/// Adds pattern-matching-related methods to [OwnerBillEvent].
extension OwnerBillEventPatterns on OwnerBillEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetList value)?  getList,TResult Function( _GetDetail value)?  getDetail,TResult Function( _Create value)?  create,TResult Function( _Update value)?  update,TResult Function( _MarkPaid value)?  markPaid,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetList() when getList != null:
return getList(_that);case _GetDetail() when getDetail != null:
return getDetail(_that);case _Create() when create != null:
return create(_that);case _Update() when update != null:
return update(_that);case _MarkPaid() when markPaid != null:
return markPaid(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetList value)  getList,required TResult Function( _GetDetail value)  getDetail,required TResult Function( _Create value)  create,required TResult Function( _Update value)  update,required TResult Function( _MarkPaid value)  markPaid,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetList():
return getList(_that);case _GetDetail():
return getDetail(_that);case _Create():
return create(_that);case _Update():
return update(_that);case _MarkPaid():
return markPaid(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetList value)?  getList,TResult? Function( _GetDetail value)?  getDetail,TResult? Function( _Create value)?  create,TResult? Function( _Update value)?  update,TResult? Function( _MarkPaid value)?  markPaid,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetList() when getList != null:
return getList(_that);case _GetDetail() when getDetail != null:
return getDetail(_that);case _Create() when create != null:
return create(_that);case _Update() when update != null:
return update(_that);case _MarkPaid() when markPaid != null:
return markPaid(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String? status,  String? period,  int page)?  getList,TResult Function( int id)?  getDetail,TResult Function( OwnerBillCreateRequestModel request)?  create,TResult Function( int id,  OwnerBillUpdateRequestModel request)?  update,TResult Function( int id)?  markPaid,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetList() when getList != null:
return getList(_that.status,_that.period,_that.page);case _GetDetail() when getDetail != null:
return getDetail(_that.id);case _Create() when create != null:
return create(_that.request);case _Update() when update != null:
return update(_that.id,_that.request);case _MarkPaid() when markPaid != null:
return markPaid(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String? status,  String? period,  int page)  getList,required TResult Function( int id)  getDetail,required TResult Function( OwnerBillCreateRequestModel request)  create,required TResult Function( int id,  OwnerBillUpdateRequestModel request)  update,required TResult Function( int id)  markPaid,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetList():
return getList(_that.status,_that.period,_that.page);case _GetDetail():
return getDetail(_that.id);case _Create():
return create(_that.request);case _Update():
return update(_that.id,_that.request);case _MarkPaid():
return markPaid(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String? status,  String? period,  int page)?  getList,TResult? Function( int id)?  getDetail,TResult? Function( OwnerBillCreateRequestModel request)?  create,TResult? Function( int id,  OwnerBillUpdateRequestModel request)?  update,TResult? Function( int id)?  markPaid,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetList() when getList != null:
return getList(_that.status,_that.period,_that.page);case _GetDetail() when getDetail != null:
return getDetail(_that.id);case _Create() when create != null:
return create(_that.request);case _Update() when update != null:
return update(_that.id,_that.request);case _MarkPaid() when markPaid != null:
return markPaid(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements OwnerBillEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerBillEvent.started()';
}


}




/// @nodoc


class _GetList implements OwnerBillEvent {
  const _GetList({this.status, this.period, this.page = 1});
  

 final  String? status;
 final  String? period;
@JsonKey() final  int page;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetListCopyWith<_GetList> get copyWith => __$GetListCopyWithImpl<_GetList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetList&&(identical(other.status, status) || other.status == status)&&(identical(other.period, period) || other.period == period)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,status,period,page);

@override
String toString() {
  return 'OwnerBillEvent.getList(status: $status, period: $period, page: $page)';
}


}

/// @nodoc
abstract mixin class _$GetListCopyWith<$Res> implements $OwnerBillEventCopyWith<$Res> {
  factory _$GetListCopyWith(_GetList value, $Res Function(_GetList) _then) = __$GetListCopyWithImpl;
@useResult
$Res call({
 String? status, String? period, int page
});




}
/// @nodoc
class __$GetListCopyWithImpl<$Res>
    implements _$GetListCopyWith<$Res> {
  __$GetListCopyWithImpl(this._self, this._then);

  final _GetList _self;
  final $Res Function(_GetList) _then;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? period = freezed,Object? page = null,}) {
  return _then(_GetList(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _GetDetail implements OwnerBillEvent {
  const _GetDetail(this.id);
  

 final  int id;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDetailCopyWith<_GetDetail> get copyWith => __$GetDetailCopyWithImpl<_GetDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'OwnerBillEvent.getDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class _$GetDetailCopyWith<$Res> implements $OwnerBillEventCopyWith<$Res> {
  factory _$GetDetailCopyWith(_GetDetail value, $Res Function(_GetDetail) _then) = __$GetDetailCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$GetDetailCopyWithImpl<$Res>
    implements _$GetDetailCopyWith<$Res> {
  __$GetDetailCopyWithImpl(this._self, this._then);

  final _GetDetail _self;
  final $Res Function(_GetDetail) _then;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_GetDetail(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Create implements OwnerBillEvent {
  const _Create(this.request);
  

 final  OwnerBillCreateRequestModel request;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCopyWith<_Create> get copyWith => __$CreateCopyWithImpl<_Create>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Create&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'OwnerBillEvent.create(request: $request)';
}


}

/// @nodoc
abstract mixin class _$CreateCopyWith<$Res> implements $OwnerBillEventCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) _then) = __$CreateCopyWithImpl;
@useResult
$Res call({
 OwnerBillCreateRequestModel request
});




}
/// @nodoc
class __$CreateCopyWithImpl<$Res>
    implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(this._self, this._then);

  final _Create _self;
  final $Res Function(_Create) _then;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_Create(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as OwnerBillCreateRequestModel,
  ));
}


}

/// @nodoc


class _Update implements OwnerBillEvent {
  const _Update(this.id, this.request);
  

 final  int id;
 final  OwnerBillUpdateRequestModel request;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCopyWith<_Update> get copyWith => __$UpdateCopyWithImpl<_Update>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Update&&(identical(other.id, id) || other.id == id)&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,id,request);

@override
String toString() {
  return 'OwnerBillEvent.update(id: $id, request: $request)';
}


}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res> implements $OwnerBillEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) = __$UpdateCopyWithImpl;
@useResult
$Res call({
 int id, OwnerBillUpdateRequestModel request
});




}
/// @nodoc
class __$UpdateCopyWithImpl<$Res>
    implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? request = null,}) {
  return _then(_Update(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as OwnerBillUpdateRequestModel,
  ));
}


}

/// @nodoc


class _MarkPaid implements OwnerBillEvent {
  const _MarkPaid(this.id);
  

 final  int id;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkPaidCopyWith<_MarkPaid> get copyWith => __$MarkPaidCopyWithImpl<_MarkPaid>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkPaid&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'OwnerBillEvent.markPaid(id: $id)';
}


}

/// @nodoc
abstract mixin class _$MarkPaidCopyWith<$Res> implements $OwnerBillEventCopyWith<$Res> {
  factory _$MarkPaidCopyWith(_MarkPaid value, $Res Function(_MarkPaid) _then) = __$MarkPaidCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$MarkPaidCopyWithImpl<$Res>
    implements _$MarkPaidCopyWith<$Res> {
  __$MarkPaidCopyWithImpl(this._self, this._then);

  final _MarkPaid _self;
  final $Res Function(_MarkPaid) _then;

/// Create a copy of OwnerBillEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_MarkPaid(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$OwnerBillState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerBillState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerBillState()';
}


}

/// @nodoc
class $OwnerBillStateCopyWith<$Res>  {
$OwnerBillStateCopyWith(OwnerBillState _, $Res Function(OwnerBillState) __);
}


/// Adds pattern-matching-related methods to [OwnerBillState].
extension OwnerBillStatePatterns on OwnerBillState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _ListLoaded value)?  listLoaded,TResult Function( _DetailLoaded value)?  detailLoaded,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ListLoaded() when listLoaded != null:
return listLoaded(_that);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _ListLoaded value)  listLoaded,required TResult Function( _DetailLoaded value)  detailLoaded,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _ListLoaded():
return listLoaded(_that);case _DetailLoaded():
return detailLoaded(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _ListLoaded value)?  listLoaded,TResult? Function( _DetailLoaded value)?  detailLoaded,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ListLoaded() when listLoaded != null:
return listLoaded(_that);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OwnerBillModel> items,  OwnerBillMetaModel? meta)?  listLoaded,TResult Function( OwnerBillModel? item)?  detailLoaded,TResult Function( String message)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ListLoaded() when listLoaded != null:
return listLoaded(_that.items,_that.meta);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that.item);case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OwnerBillModel> items,  OwnerBillMetaModel? meta)  listLoaded,required TResult Function( OwnerBillModel? item)  detailLoaded,required TResult Function( String message)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _ListLoaded():
return listLoaded(_that.items,_that.meta);case _DetailLoaded():
return detailLoaded(_that.item);case _Success():
return success(_that.message);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OwnerBillModel> items,  OwnerBillMetaModel? meta)?  listLoaded,TResult? Function( OwnerBillModel? item)?  detailLoaded,TResult? Function( String message)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ListLoaded() when listLoaded != null:
return listLoaded(_that.items,_that.meta);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that.item);case _Success() when success != null:
return success(_that.message);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements OwnerBillState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerBillState.initial()';
}


}




/// @nodoc


class _Loading implements OwnerBillState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OwnerBillState.loading()';
}


}




/// @nodoc


class _ListLoaded implements OwnerBillState {
  const _ListLoaded( List<OwnerBillModel> items, this.meta): _items = items;
  

 final  List<OwnerBillModel> _items;
 List<OwnerBillModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  OwnerBillMetaModel? meta;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListLoadedCopyWith<_ListLoaded> get copyWith => __$ListLoadedCopyWithImpl<_ListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListLoaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);

@override
String toString() {
  return 'OwnerBillState.listLoaded(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$ListLoadedCopyWith<$Res> implements $OwnerBillStateCopyWith<$Res> {
  factory _$ListLoadedCopyWith(_ListLoaded value, $Res Function(_ListLoaded) _then) = __$ListLoadedCopyWithImpl;
@useResult
$Res call({
 List<OwnerBillModel> items, OwnerBillMetaModel? meta
});




}
/// @nodoc
class __$ListLoadedCopyWithImpl<$Res>
    implements _$ListLoadedCopyWith<$Res> {
  __$ListLoadedCopyWithImpl(this._self, this._then);

  final _ListLoaded _self;
  final $Res Function(_ListLoaded) _then;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = freezed,}) {
  return _then(_ListLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OwnerBillModel>,freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as OwnerBillMetaModel?,
  ));
}


}

/// @nodoc


class _DetailLoaded implements OwnerBillState {
  const _DetailLoaded(this.item);
  

 final  OwnerBillModel? item;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailLoadedCopyWith<_DetailLoaded> get copyWith => __$DetailLoadedCopyWithImpl<_DetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailLoaded&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'OwnerBillState.detailLoaded(item: $item)';
}


}

/// @nodoc
abstract mixin class _$DetailLoadedCopyWith<$Res> implements $OwnerBillStateCopyWith<$Res> {
  factory _$DetailLoadedCopyWith(_DetailLoaded value, $Res Function(_DetailLoaded) _then) = __$DetailLoadedCopyWithImpl;
@useResult
$Res call({
 OwnerBillModel? item
});




}
/// @nodoc
class __$DetailLoadedCopyWithImpl<$Res>
    implements _$DetailLoadedCopyWith<$Res> {
  __$DetailLoadedCopyWithImpl(this._self, this._then);

  final _DetailLoaded _self;
  final $Res Function(_DetailLoaded) _then;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = freezed,}) {
  return _then(_DetailLoaded(
freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as OwnerBillModel?,
  ));
}


}

/// @nodoc


class _Success implements OwnerBillState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OwnerBillState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $OwnerBillStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements OwnerBillState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OwnerBillState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $OwnerBillStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of OwnerBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
