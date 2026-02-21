library foo;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/models/models.dart'; // Models are imported, not parted

// The Stitching
part 'domain/repository/foo_repository.dart';
part 'data/repository/foo_repository_impl.dart';
part 'presentation/providers/foo_provider.dart';
