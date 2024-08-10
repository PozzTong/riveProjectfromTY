class MusicInfo {
  final bool isOn;
  final Song currentSong;

  MusicInfo({required this.isOn, required this.currentSong});
}

class Song {
  Song(this.title, this.artist, this.thumbUrl);

  final String title;
  final String artist;
  final String thumbUrl;

  static Song defaultSong = Song(
    'I wanna be your slave',
    'MANESKIN',
    'https://i.ibb.co/bQ65QkD/manesking.jpg',
  );
}
