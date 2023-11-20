class PlayerNameAlreadyExistsException implements Exception {
  final String message;

  PlayerNameAlreadyExistsException(this.message);
}
