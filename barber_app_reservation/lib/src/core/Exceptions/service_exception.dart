// final class não pode ser extendida ou implementada
final class ServiceException implements Exception {
  final String message;

  ServiceException({required this.message});
}
