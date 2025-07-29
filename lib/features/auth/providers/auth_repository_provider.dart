import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';

/// Provider for the AuthRepository
final authRepositoryProvider = Provider((ref) => AuthRepository());