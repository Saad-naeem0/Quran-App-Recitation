import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyric_ui/ui_netease.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:audioplayers/audioplayers.dart';

class Recitation extends StatefulWidget {
  @override
  State<Recitation> createState() => _RecitationState();
}

class _RecitationState extends State<Recitation> {
  // var lyricUi = UINetease();
  final audioPlayer1 = AudioPlayer();
  Duration duration = Duration.zero;
  bool isPlaying = false;
  Duration position = Duration.zero;

// @override
  final List<String> _ayah = <String>[
    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
    'ٱلْحَمْدُ لِلَّٰهِ',
    'الله أكبر',
    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ'
  ];

  final List<String> _translation = <String>['abc', 'def', 'abc', 'def'];

  final List<String> _urduTrans = <String>['آسان', 'مشکل', "اچھا", 'برا'];

  // AudioCache audioCache = AudioCache();

  // AudioPlayer? audioPlayer;

  // double sliderProgress = 0;

  // int playProgress = 0;

  // double max_value = 100;

  // bool isTap = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAudio();

    //  LIsten to states: playing/paused/ stoped
    audioPlayer1.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    //here we listen to audio duration if need be
    audioPlayer1.onDurationChanged.listen((event) {
      setState(() {
        // duration = newDuration;
      });
    });
    //listen to audio position
    audioPlayer1.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    // String url = '';
    // audioPlayer1.setSourceUrl(url);
    audioPlayer1.setReleaseMode(ReleaseMode.loop);
    // load audio from file
    // final file = File(...);
    // audioPlayer1.setSourceUrl()

    //load audio from assets (assets/ayah1.mp3)
    final player = AudioCache(prefix: 'asset/');
    final audio1 = await player.load('ayah1.mp3');
    audioPlayer1.setSourceUrl(
      audio1.path,
    );
    // final player1 =
    //     await audioPlayer1.setSource(AssetSource('asset/ayah1.mp3'));
  }

  @override
  void dispose() {
    audioPlayer1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> colorCodes = <int>[50, 100, 50, 100];
    // [for (int i=0; i<=_ayah.length; i++){
    //   if(i%2==0){
    //     50
    //   }
    //   else{
    //     100
    //   }
    // }.length];
    var height = MediaQuery.of(context).size.height * .3;
    var width = MediaQuery.of(context).size.width * .1;
    // var sno = for(int i=1; i<=_translation.length; i++);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _ayah.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: height,
                  color: Colors.green[colorCodes[index]],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_ayah[index]}        ۝ ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black87,
                              fontFamily: 'Quranic'),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${_translation[index]}',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${_urduTrans[index]}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer1.seek(position);

                              await audioPlayer1.resume();
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 330),
                          child: IconButton(
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer1.pause();
                              } else {
                                // String url = '';
                                // await audioPlayer1.play(url);
                                await audioPlayer1.resume();
                              }
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ],
                    ),
                  )
                  // Center(child: Text('1 ${entries[index]}')),
                  );
            }),
      ),
    );
  }
}
