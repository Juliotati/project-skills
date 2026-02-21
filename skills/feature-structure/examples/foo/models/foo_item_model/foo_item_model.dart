import 'package:freezed_annotation/freezed_annotation.dart';

part 'foo_item_model.freezed.dart';
part 'foo_item_model.g.dart';

@freezed
class FooItemModel with _$FooItemModel {
  const factory FooItemModel({required String id}) = _FooItemModel;
  factory FooItemModel.fromJson(Map<String, dynamic> json) => _$FooItemModelFromJson(json);
}
