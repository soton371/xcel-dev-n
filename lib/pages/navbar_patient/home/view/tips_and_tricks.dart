import 'package:flutter/material.dart';
import 'package:xcel_medical_center/widgets/play_youtube_video.dart';

class TipsAndTricks extends StatefulWidget {
  final String? videoUrl;
  final String? videoTitle;
  final String? videoDuration;
  const TipsAndTricks({super.key, 
    @required this.videoUrl,
    @required this.videoTitle,
    @required this.videoDuration,
  });

  @override
  TipsAndTricksState createState() => TipsAndTricksState();
}

class TipsAndTricksState extends State<TipsAndTricks> {
  bool isVideoAvailable = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        playYoutubeVideo(
          context: context,
          videoId: widget.videoUrl??'',
        );
       
      },
      child: Container(
        width: 210,
        margin: const EdgeInsets.only(right: 5),
        child: Card(
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      'https://i3.ytimg.com/vi_webp/${widget.videoUrl}/sddefault.webp',
                      height: 105,
                      width: 210,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        
                        Future.delayed(Duration.zero, () async {
                          setState(() {
                            isVideoAvailable = false;
                          });
                        });
                        return Center(
                          child: Image.asset(
                            'assets/images/no_img.png',
                            height: 105,
                            width: 210,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 80,
                    child: Image.asset(
                      'assets/images/youtube.png',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: const BorderRadius.all(Radius.circular(3))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          widget.videoDuration??'',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
                child: Text(
                  widget.videoTitle??'',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
