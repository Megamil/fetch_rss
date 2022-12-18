import 'package:fetch_rss/fetch_rss.dart';
import 'package:fetch_rss/helper/secure_print.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch RSS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const VideosListPage(title: 'Fetch RSS'),
    );
  }
}

class VideosListPage extends StatefulWidget {
  const VideosListPage({super.key, required this.title});
  final String title;

  @override
  State<VideosListPage> createState() => _VideosListPageState();
}

class _VideosListPageState extends State<VideosListPage> {

  ///How to find channel id of any channel
  /// https://commentpicker.com/youtube-channel-id.php
  static String channelId = "UCLTWPE7XrHEe8m_xAmNbQ-Q"; //Ancap channel, no copyright concerns
  YoutubeRSSModel? model;

  void getVideos() async {
    SecurePrint.log("getVideos -> $channelId");
    model = await FetchRSSYoutube.fetch(channelId);
    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(model?.channelTitle ?? widget.title),
        ),
        body:  SafeArea(child:
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: model != null ? createList() : loadingView()
        ),
        )
    );
  }

  Widget createList() {

    return ListView.builder(
      itemCount: model?.entryList?.length,
      itemBuilder: (context, index) {
        final video = model?.entryList?[index];
        return Column(
          children: [
            Image.network("${video?.thumbnail}"),
            Text("${video?.title}"),
            Text("Views: ${video?.views} | Likes: ${video?.likes}"),
          ],
        );
      },
    );

  }

  Widget loadingView() {
    return Center(child:
      Column(
        children: const [
          CircularProgressIndicator(
            backgroundColor: Colors.green,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 4.0,
          ),
          Text("Loading..."),
        ],
      ),
    );
  }

}
