// lib/presentation/providers/regiment_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/regiment_repository_impl.dart';
import '../../data/sources/local/regiment_local_data_source.dart';
import '../../domain/models/regiment.dart';
import '../../domain/repositories/regiment_repository.dart';

final regimentRepositoryProvider = Provider<RegimentRepository>((ref) {
  final dataSource = RegimentLocalDataSource();
  return RegimentRepositoryImpl(dataSource);
});

final allRegimentsProvider = FutureProvider<List<Regiment>>((ref) {
  final repository = ref.watch(regimentRepositoryProvider);
  return repository.getAllRegiments();
});

final regimentsByFactionProvider =
    FutureProvider.family<List<Regiment>, String>((ref, faction) {
  final repository = ref.watch(regimentRepositoryProvider);
  return repository.getRegimentsByFaction(faction);
});

final regimentByNameProvider =
    FutureProvider.family<Regiment?, String>((ref, name) {
  final repository = ref.watch(regimentRepositoryProvider);
  return repository.getRegimentByName(name);
});
