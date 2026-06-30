// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TenantPaymentEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantPaymentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentEvent()';
}


}

/// @nodoc
class $TenantPaymentEventCopyWith<$Res>  {
$TenantPaymentEventCopyWith(TenantPaymentEvent _, $Res Function(TenantPaymentEvent) __);
}


/// Adds pattern-matching-related methods to [TenantPaymentEvent].
extension TenantPaymentEventPatterns on TenantPaymentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetList value)?  getList,TResult Function( _Simulate value)?  simulate,TResult Function( _GetReceipt value)?  getReceipt,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetList() when getList != null:
return getList(_that);case _Simulate() when simulate != null:
return simulate(_that);case _GetReceipt() when getReceipt != null:
return getReceipt(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetList value)  getList,required TResult Function( _Simulate value)  simulate,required TResult Function( _GetReceipt value)  getReceipt,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetList():
return getList(_that);case _Simulate():
return simulate(_that);case _GetReceipt():
return getReceipt(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetList value)?  getList,TResult? Function( _Simulate value)?  simulate,TResult? Function( _GetReceipt value)?  getReceipt,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetList() when getList != null:
return getList(_that);case _Simulate() when simulate != null:
return simulate(_that);case _GetReceipt() when getReceipt != null:
return getReceipt(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  getList,TResult Function( int billId)?  simulate,TResult Function( int paymentId)?  getReceipt,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetList() when getList != null:
return getList();case _Simulate() when simulate != null:
return simulate(_that.billId);case _GetReceipt() when getReceipt != null:
return getReceipt(_that.paymentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  getList,required TResult Function( int billId)  simulate,required TResult Function( int paymentId)  getReceipt,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetList():
return getList();case _Simulate():
return simulate(_that.billId);case _GetReceipt():
return getReceipt(_that.paymentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  getList,TResult? Function( int billId)?  simulate,TResult? Function( int paymentId)?  getReceipt,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetList() when getList != null:
return getList();case _Simulate() when simulate != null:
return simulate(_that.billId);case _GetReceipt() when getReceipt != null:
return getReceipt(_that.paymentId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TenantPaymentEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentEvent.started()';
}


}




/// @nodoc


class _GetList implements TenantPaymentEvent {
  const _GetList();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentEvent.getList()';
}


}




/// @nodoc


class _Simulate implements TenantPaymentEvent {
  const _Simulate(this.billId);
  

 final  int billId;

/// Create a copy of TenantPaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimulateCopyWith<_Simulate> get copyWith => __$SimulateCopyWithImpl<_Simulate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Simulate&&(identical(other.billId, billId) || other.billId == billId));
}


@override
int get hashCode => Object.hash(runtimeType,billId);

@override
String toString() {
  return 'TenantPaymentEvent.simulate(billId: $billId)';
}


}

/// @nodoc
abstract mixin class _$SimulateCopyWith<$Res> implements $TenantPaymentEventCopyWith<$Res> {
  factory _$SimulateCopyWith(_Simulate value, $Res Function(_Simulate) _then) = __$SimulateCopyWithImpl;
@useResult
$Res call({
 int billId
});




}
/// @nodoc
class __$SimulateCopyWithImpl<$Res>
    implements _$SimulateCopyWith<$Res> {
  __$SimulateCopyWithImpl(this._self, this._then);

  final _Simulate _self;
  final $Res Function(_Simulate) _then;

/// Create a copy of TenantPaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? billId = null,}) {
  return _then(_Simulate(
null == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _GetReceipt implements TenantPaymentEvent {
  const _GetReceipt(this.paymentId);
  

 final  int paymentId;

/// Create a copy of TenantPaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetReceiptCopyWith<_GetReceipt> get copyWith => __$GetReceiptCopyWithImpl<_GetReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetReceipt&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'TenantPaymentEvent.getReceipt(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$GetReceiptCopyWith<$Res> implements $TenantPaymentEventCopyWith<$Res> {
  factory _$GetReceiptCopyWith(_GetReceipt value, $Res Function(_GetReceipt) _then) = __$GetReceiptCopyWithImpl;
@useResult
$Res call({
 int paymentId
});




}
/// @nodoc
class __$GetReceiptCopyWithImpl<$Res>
    implements _$GetReceiptCopyWith<$Res> {
  __$GetReceiptCopyWithImpl(this._self, this._then);

  final _GetReceipt _self;
  final $Res Function(_GetReceipt) _then;

/// Create a copy of TenantPaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(_GetReceipt(
null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TenantPaymentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantPaymentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentState()';
}


}

/// @nodoc
class $TenantPaymentStateCopyWith<$Res>  {
$TenantPaymentStateCopyWith(TenantPaymentState _, $Res Function(TenantPaymentState) __);
}


/// Adds pattern-matching-related methods to [TenantPaymentState].
extension TenantPaymentStatePatterns on TenantPaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _ListLoaded value)?  listLoaded,TResult Function( _PaymentSuccess value)?  paymentSuccess,TResult Function( _ReceiptLoaded value)?  receiptLoaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ListLoaded() when listLoaded != null:
return listLoaded(_that);case _PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that);case _ReceiptLoaded() when receiptLoaded != null:
return receiptLoaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _ListLoaded value)  listLoaded,required TResult Function( _PaymentSuccess value)  paymentSuccess,required TResult Function( _ReceiptLoaded value)  receiptLoaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _ListLoaded():
return listLoaded(_that);case _PaymentSuccess():
return paymentSuccess(_that);case _ReceiptLoaded():
return receiptLoaded(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _ListLoaded value)?  listLoaded,TResult? Function( _PaymentSuccess value)?  paymentSuccess,TResult? Function( _ReceiptLoaded value)?  receiptLoaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ListLoaded() when listLoaded != null:
return listLoaded(_that);case _PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that);case _ReceiptLoaded() when receiptLoaded != null:
return receiptLoaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TenantPaymentModel> items)?  listLoaded,TResult Function( String message,  TenantPaymentModel? payment)?  paymentSuccess,TResult Function( TenantPaymentReceiptModel? receipt)?  receiptLoaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ListLoaded() when listLoaded != null:
return listLoaded(_that.items);case _PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that.message,_that.payment);case _ReceiptLoaded() when receiptLoaded != null:
return receiptLoaded(_that.receipt);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TenantPaymentModel> items)  listLoaded,required TResult Function( String message,  TenantPaymentModel? payment)  paymentSuccess,required TResult Function( TenantPaymentReceiptModel? receipt)  receiptLoaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _ListLoaded():
return listLoaded(_that.items);case _PaymentSuccess():
return paymentSuccess(_that.message,_that.payment);case _ReceiptLoaded():
return receiptLoaded(_that.receipt);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TenantPaymentModel> items)?  listLoaded,TResult? Function( String message,  TenantPaymentModel? payment)?  paymentSuccess,TResult? Function( TenantPaymentReceiptModel? receipt)?  receiptLoaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ListLoaded() when listLoaded != null:
return listLoaded(_that.items);case _PaymentSuccess() when paymentSuccess != null:
return paymentSuccess(_that.message,_that.payment);case _ReceiptLoaded() when receiptLoaded != null:
return receiptLoaded(_that.receipt);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements TenantPaymentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentState.initial()';
}


}




/// @nodoc


class _Loading implements TenantPaymentState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TenantPaymentState.loading()';
}


}




/// @nodoc


class _ListLoaded implements TenantPaymentState {
  const _ListLoaded( List<TenantPaymentModel> items): _items = items;
  

 final  List<TenantPaymentModel> _items;
 List<TenantPaymentModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListLoadedCopyWith<_ListLoaded> get copyWith => __$ListLoadedCopyWithImpl<_ListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TenantPaymentState.listLoaded(items: $items)';
}


}

/// @nodoc
abstract mixin class _$ListLoadedCopyWith<$Res> implements $TenantPaymentStateCopyWith<$Res> {
  factory _$ListLoadedCopyWith(_ListLoaded value, $Res Function(_ListLoaded) _then) = __$ListLoadedCopyWithImpl;
@useResult
$Res call({
 List<TenantPaymentModel> items
});




}
/// @nodoc
class __$ListLoadedCopyWithImpl<$Res>
    implements _$ListLoadedCopyWith<$Res> {
  __$ListLoadedCopyWithImpl(this._self, this._then);

  final _ListLoaded _self;
  final $Res Function(_ListLoaded) _then;

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_ListLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TenantPaymentModel>,
  ));
}


}

/// @nodoc


class _PaymentSuccess implements TenantPaymentState {
  const _PaymentSuccess(this.message, this.payment);
  

 final  String message;
 final  TenantPaymentModel? payment;

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentSuccessCopyWith<_PaymentSuccess> get copyWith => __$PaymentSuccessCopyWithImpl<_PaymentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSuccess&&(identical(other.message, message) || other.message == message)&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode => Object.hash(runtimeType,message,payment);

@override
String toString() {
  return 'TenantPaymentState.paymentSuccess(message: $message, payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$PaymentSuccessCopyWith<$Res> implements $TenantPaymentStateCopyWith<$Res> {
  factory _$PaymentSuccessCopyWith(_PaymentSuccess value, $Res Function(_PaymentSuccess) _then) = __$PaymentSuccessCopyWithImpl;
@useResult
$Res call({
 String message, TenantPaymentModel? payment
});




}
/// @nodoc
class __$PaymentSuccessCopyWithImpl<$Res>
    implements _$PaymentSuccessCopyWith<$Res> {
  __$PaymentSuccessCopyWithImpl(this._self, this._then);

  final _PaymentSuccess _self;
  final $Res Function(_PaymentSuccess) _then;

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? payment = freezed,}) {
  return _then(_PaymentSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as TenantPaymentModel?,
  ));
}


}

/// @nodoc


class _ReceiptLoaded implements TenantPaymentState {
  const _ReceiptLoaded(this.receipt);
  

 final  TenantPaymentReceiptModel? receipt;

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptLoadedCopyWith<_ReceiptLoaded> get copyWith => __$ReceiptLoadedCopyWithImpl<_ReceiptLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptLoaded&&(identical(other.receipt, receipt) || other.receipt == receipt));
}


@override
int get hashCode => Object.hash(runtimeType,receipt);

@override
String toString() {
  return 'TenantPaymentState.receiptLoaded(receipt: $receipt)';
}


}

/// @nodoc
abstract mixin class _$ReceiptLoadedCopyWith<$Res> implements $TenantPaymentStateCopyWith<$Res> {
  factory _$ReceiptLoadedCopyWith(_ReceiptLoaded value, $Res Function(_ReceiptLoaded) _then) = __$ReceiptLoadedCopyWithImpl;
@useResult
$Res call({
 TenantPaymentReceiptModel? receipt
});




}
/// @nodoc
class __$ReceiptLoadedCopyWithImpl<$Res>
    implements _$ReceiptLoadedCopyWith<$Res> {
  __$ReceiptLoadedCopyWithImpl(this._self, this._then);

  final _ReceiptLoaded _self;
  final $Res Function(_ReceiptLoaded) _then;

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? receipt = freezed,}) {
  return _then(_ReceiptLoaded(
freezed == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as TenantPaymentReceiptModel?,
  ));
}


}

/// @nodoc


class _Error implements TenantPaymentState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of TenantPaymentState
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
  return 'TenantPaymentState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $TenantPaymentStateCopyWith<$Res> {
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

/// Create a copy of TenantPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
