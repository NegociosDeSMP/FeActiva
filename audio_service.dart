import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  bool _initialized = false;

  Future<void> toggleBackgroundMusic() async {
    if (_player.state == PlayerState.playing) {
      await _player.pause();
      return;
    }
    if (!_initialized) {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setSource(AssetSource('audio/musica3.mp3'));
      _initialized = true;
      await _player.play(AssetSource('audio/musica3.mp3'));
      return;
    }
    await _player.resume();
  }

  Future<void> dispose() => _player.dispose();
}
