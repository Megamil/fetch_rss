import 'package:fetch_rss/helper/secure_print.dart';
import 'package:fetch_rss/src/models/youtube_rss_model.dart';
export 'package:fetch_rss/src/models/youtube_rss_model.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class FetchRSSYoutube {

  ///In case of the error in chrome: XMLHttpRequest error
  /// 1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
  /// 2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
  /// 3- Replace '--disable-extensions' by '--disable-web-security'
  static Future<YoutubeRSSModel?> fetch(String channelId) async {

    YoutubeRSSModel? model;
    List<YoutubeVideo>? modelEntryList = [];

    try {
      final response = await http.get(Uri.parse("https://www.youtube.com/feeds/videos.xml?channel_id=$channelId"), headers: {"Access-Control-Allow-Origin": "*", 'Accept': '*/*'});
      if (response.statusCode == 200) {

        final document = XmlDocument.parse(response.body);
        // Get the 'feed' root element
        final feedElement = document.rootElement;

        // Get the channel title
        final channelTitle = feedElement.findElements('title').first.text;

        // Get the channel link
        final channelUrl = feedElement.findElements('link').firstWhere((element) => element.getAttribute('rel') == 'alternate').getAttribute('href');

        // Get the 'author' element
        final authorElement = feedElement.findElements('author').first;

        // Get the author's name
        final channelAuthorName = authorElement.findElements('name').first.text;

        // Get the author's URI
        final channelAuthorUrl = authorElement.findElements('uri').first.text;

        // Get the publication date
        final channelPublishedAt = DateTime.parse(feedElement.findElements('published').first.text);

        final entryList =  feedElement.findElements('entry');
        for (var entry in entryList) {

          final title = entry.findElements('title').first.text;

          // Get the link to the video
          final link = entry.findElements('link').firstWhere((element) => element.getAttribute('rel') == 'alternate').getAttribute('href');

          // Get the publication date of the video
          final published = DateTime.parse(entry.findElements('published').first.text);

          // Get the 'media:group' element
          final mediaGroupElement = entry.findElements('media:group').first;

          // Get the video description
          final description = mediaGroupElement.findElements('media:description').first.text;

          // Get the thumbnail of the video
          final thumbnail = mediaGroupElement.findElements('media:thumbnail').first.getAttribute('url');

          // Get the 'media:community' element
          final mediaCommunityElement = mediaGroupElement.findElements('media:community').first;

          // Get the number of likes
          final likes = int.parse(mediaCommunityElement.findElements('media:starRating').first.getAttribute('count') ?? "0");

          // Get the number of views
          final views = int.parse(mediaCommunityElement.findElements('media:statistics').first.getAttribute('views') ?? "0");

          YoutubeVideo? video = YoutubeVideo(title: title, link: link, published: published, description: description, thumbnail: thumbnail, likes: likes, views: views);
          modelEntryList.add(video);
        }

        model = YoutubeRSSModel(channelTitle: channelTitle, channelUrl: channelUrl, channelAuthorName: channelAuthorName, channelAuthorUrl: channelAuthorUrl, channelPublishedAt: channelPublishedAt, entryList: modelEntryList);
        model.success = true;
        model.message = "OK";

      } else {
        model = YoutubeRSSModel();
        model.success = false;
        model.message = "Status Code: ${response.statusCode}\nBody: ${response.body.toString()}""";
      }

    } catch (e) {
      model = YoutubeRSSModel();
      model.success = false;
      model.message = e.toString();
    }

    model.log();
    return model;

  }

}