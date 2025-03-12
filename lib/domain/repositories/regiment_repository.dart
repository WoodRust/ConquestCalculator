// lib/domain/repositories/regiment_repository.dart
import '../models/regiment.dart';

abstract class RegimentRepository {
  Future<List<Regiment>> getAllRegiments();
  Future<List<Regiment>> getRegimentsByFaction(String faction);
  Future<Regiment?> getRegimentByName(String name);
}
