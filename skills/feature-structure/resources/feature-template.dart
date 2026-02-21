library {{feature_name}};

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/models/models.dart';
import 'presentation/providers/{{feature_name}}_provider.dart';

part 'domain/repository/{{feature_name}}_repository.dart';
part 'data/data_sources/local_data_source.dart';
part 'data/data_sources/remote_data_source.dart';
part 'data/repository/{{feature_name}}_repository_impl.dart';
