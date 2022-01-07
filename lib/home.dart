import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "assets/audios/");
  bool primeiraExecucao = true;
  double volume = 0.5;

  _executar() async {
    audioPlayer.setVolume(volume);
    if (primeiraExecucao) {
      audioPlayer = await audioCache.play("jay_park_all_i_wanna_do.mp3");
      primeiraExecucao = false;
    } else {
      audioPlayer.resume();
    }

    // String url =
    //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3";
    // int resultado = await audioPlayer.play(url);
    // if (resultado == 1) {}
  }

  _pausar() async {
    int resultado = await audioPlayer.pause();
  }

  _parar() async {
    int resultado = await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Executando sons",
            style: TextStyle(color: Color(0xFFBEBEBE)),
          ),
          backgroundColor: Color(0xFF160C2C),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shadowColor: Colors.black,
              elevation: 20,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/images/play.png",
                        width: 40,
                        height: 40,
                      ),
                      onTap: () {
                        _executar();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/images/pause.png",
                        width: 40,
                        height: 40,
                      ),
                      onTap: () {
                        _pausar();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      child: Image.asset(
                        "assets/images/stop.png",
                        width: 40,
                        height: 40,
                      ),
                      onTap: () {
                        _parar();
                      },
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Slider(
                      activeColor: Color(0xFF160C2C),
                      thumbColor: Color(0xFF160C2C),
                      inactiveColor: Color(0xFFBEBEBE),
                        value: volume,
                        min: 0,
                        max: 1,
                        onChanged: (novoVolume) {
                          setState(() {
                            volume = novoVolume;
                          });
                          audioPlayer.setVolume(novoVolume);
                        }),
                    )
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
