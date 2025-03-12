// lib/data/repositories/regiment_repository_impl.dart
import '../../domain/models/regiment.dart';
import '../../domain/repositories/regiment_repository.dart';
import '../sources/local/regiment_local_data_source.dart';

class RegimentRepositoryImpl implements RegimentRepository {
  final RegimentLocalDataSource _localDataSource;

  RegimentRepositoryImpl(this._localDataSource);

  @override
  Future<List<Regiment>> getAllRegiments() async {
    final regimentDtos = await _localDataSource.getAllRegiments();
    return regimentDtos.map((dto) => dto.toRegiment()).toList();
  }

  @override
  Future<List<Regiment>> getRegimentsByFaction(String faction) async {
    final regimentDtos = await _localDataSource.getRegiments(faction);
    return regimentDtos.map((dto) => dto.toRegiment()).toList();
  }

  @override
  Future<Regiment?> getRegimentByName(String name) async {
    final allRegiments = await getAllRegiments();
    return allRegiments.firstWhere(
      (regiment) => regiment.name.toLowerCase() == name.toLowerCase(),
      orElse: () => throw Exception('Regiment not found: $name'),
    );
  }
}
