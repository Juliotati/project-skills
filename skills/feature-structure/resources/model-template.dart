import 'package:freezed_annotation/freezed_annotation.dart';

part '{{model_name}}_model.freezed.dart';
part '{{model_name}}_model.g.dart';

@freezed
class {{model_name_pascal}}Model with _${{model_name_pascal}}Model {
  const factory {{model_name_pascal}}Model({
    required String id,
  }) = _{{model_name_pascal}}Model;

  factory {{model_name_pascal}}Model.fromJson(Map<String, dynamic> json) => 
      _${{model_name_pascal}}ModelFromJson(json);
}
