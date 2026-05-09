import '../../{{feature_name}}.dart';
import '../../data/models/models.dart';

final class {{feature_name_pascal}}Provider extends ChangeNotifier {
  {{feature_name_pascal}}Provider(this._repository);

  final {{feature_name_pascal}}Repository _repository;
}
