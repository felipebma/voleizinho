import 'package:voleizinho/model/player.dart';

class SimilarPlayer {
  final Player player;
  final double similarity;
  final double avgDiff;

  SimilarPlayer(this.player, this.similarity, this.avgDiff);
}
