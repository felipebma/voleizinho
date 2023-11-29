class NotEnoughPlayersException implements Exception {
  final String message;

  NotEnoughPlayersException(this.message);
}
