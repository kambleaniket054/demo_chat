import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class VideoEditorUI extends StatefulWidget {
  @override
  _VideoEditorUIState createState() => _VideoEditorUIState();
}

class _VideoEditorUIState extends State<VideoEditorUI> {
  late VideoPlayerController _videoController;
  late AudioPlayer _audioPlayer;
  Duration _currentPosition = Duration.zero;
  ScrollController _scrollController = ScrollController();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
    )..initialize().then((_) {
      setState(() {});
    });
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _play() {
    _videoController.play();
    _audioPlayer.play();
    _isPlaying = true;
    _syncTimeline();
  }

  void _pause() {
    _videoController.pause();
    _audioPlayer.pause();
    _isPlaying = false;
  }

  void _syncTimeline() {
    _videoController.addListener(() {
      setState(() {
        _currentPosition = _videoController.value.position;
        _scrollTimeline();
      });
    });
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
        _scrollTimeline();
      });
    });
  }

  void _scrollTimeline() {
    if (_isPlaying) {
      double scrollPosition = (_currentPosition.inSeconds.toDouble() / 2) * 50; // Calculate the scroll position
      _scrollController.animateTo(
        scrollPosition,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline with current time indicator
          Container(
            height: 40,
            color: Colors.black54,
            child: Stack(
              children: [
                Row(
                  children: List.generate(15, (index) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${index * 2}:00",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                // Current time indicator
                Positioned(
                  left: (_currentPosition.inSeconds.toDouble() / 2) * 50, // Adjusted for 2 seconds per clip and timeline scale
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Track Controls (icons)
                Container(
                  width: 60,
                  color: Colors.black87,
                  child: Column(
                    children: List.generate(6, (index) {
                      return Expanded(
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
                // Tracks
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          // Video Track 1
                          Track(
                            clips: [
                              ClipItem(
                                color: Colors.purple,
                                width: 50, // Width corresponding to 2 seconds
                                title: "Clip 1",
                                videoController: _videoController,
                              ),
                              ClipItem(
                                color: Colors.grey,
                                width: 50, // Width corresponding to 2 seconds
                                title: "Clip 2",
                                videoController: _videoController,
                              ),
                            ],
                          ),
                          // Video Track 2
                          Track(
                            clips: [
                              ClipItem(
                                color: Colors.purpleAccent,
                                width: 50, // Width corresponding to 2 seconds
                                title: "Clip 3",
                                videoController: _videoController,
                              ),
                              ClipItem(
                                color: Colors.orange,
                                width: 50, // Width corresponding to 2 seconds
                                title: "Clip 4",
                                videoController: _videoController,
                              ),
                            ],
                          ),
                          // Audio Track
                          Track(
                            isAudio: true,
                            clips: [
                              ClipItem(
                                color: Colors.green,
                                width: 50, // Width corresponding to 2 seconds
                                title: "Audio Clip 1",
                                audioPlayer: _audioPlayer,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Play/Pause Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: _play,
                ),
                IconButton(
                  icon: Icon(Icons.pause, color: Colors.white),
                  onPressed: _pause,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Track extends StatelessWidget {
  final List<ClipItem> clips;
  final bool isAudio;

  Track({required this.clips, this.isAudio = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: isAudio ? Colors.black : Colors.black87,
      child: Row(
        children: clips,
      ),
    );
  }
}

class ClipItem extends StatelessWidget {
  final Color color;
  final double width;
  final String title;
  final VideoPlayerController? videoController;
  final AudioPlayer? audioPlayer;

  ClipItem({
    required this.color,
    required this.width,
    required this.title,
    this.videoController,
    this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}