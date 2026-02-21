library {{feature_name}};

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/models/models.dart';

// Domain
part 'domain/repository/{{feature_name}}_repository.dart';

// Data
part 'data/data_sources/{{feature_name}}_remote_data_source.dart';
part 'data/repository/{{feature_name}}_repository_impl.dart';

// Presentation
part 'presentation/providers/{{feature_name}}_provider.dart';
