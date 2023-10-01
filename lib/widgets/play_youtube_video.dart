import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void playYoutubeVideo(
    {@required BuildContext? context, @required String? videoId}) {
  showDialog(
      context: context!,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                YoutubePlayer(
                  // thumbnail: Image.network(
                  //     'https://raw.githubusercontent.com/ezatechbd/data/master/img/youtube_thumb.png'),
                  controller: YoutubePlayerController(
                    initialVideoId: videoId??'',
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
              ],
            ),
          ),
        );
      });
}
