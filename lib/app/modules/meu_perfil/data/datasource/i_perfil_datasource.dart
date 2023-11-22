abstract class IPerfilDatasource {
  Future<void> update({required String name, required String email});

  Future<void> delete();
}
