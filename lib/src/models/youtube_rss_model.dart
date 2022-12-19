import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../helper/secure_print.dart';

class YoutubeRSSModel {

  bool? success;
  String? message;

  String? channelTitle;
  String? channelUrl;
  String? channelAuthorName;
  String? channelAuthorUrl;
  DateTime? channelPublishedAt;
  List<YoutubeVideo>? entryList = [];

  YoutubeRSSModel({
    this.channelTitle,
    this.channelUrl,
    this.channelAuthorName,
    this.channelAuthorUrl,
    this.channelPublishedAt,
    this.entryList,
    String? locale = "pt_BR"
  }) {
    initializeDateFormatting(locale, null);
  }

  void log() {
    SecurePrint.log("##### YoutubeRSSModel #####");
    SecurePrint.log(channelTitle);
    SecurePrint.log(channelUrl);
    SecurePrint.log(channelAuthorName);
    SecurePrint.log(channelAuthorUrl);
    SecurePrint.log(channelPublishedAt);
    SecurePrint.log(message);
    entryList?.forEach((element) { element.log(); });
    SecurePrint.log("##### YoutubeRSSModel #####");

  }

}

class YoutubeVideo {

  String? title;
  String? link;
  DateTime? published;
  String? description;
  String? thumbnail;
  int? views;
  int? likes;

  YoutubeVideo({
    this.title,
    this.link,
    this.published,
    this.description,
    this.thumbnail,
    this.views,
    this.likes,
  });

  String? getPublished([String? newPattern = "dd/MM/yyyy HH:mm:ss", String? locale = "pt_BR"]) {
    DateFormat formatter = DateFormat(newPattern, locale);
    return formatter.format(published!);
  }

  void log() {
    SecurePrint.log("##### YoutubeVideo #####");
    SecurePrint.log(title);
    SecurePrint.log(link);
    SecurePrint.log(published);
    SecurePrint.log("##### Description #####");
    SecurePrint.log(description);
    SecurePrint.log("##### Description #####");
    SecurePrint.log(thumbnail);
    SecurePrint.log(views);
    SecurePrint.log(likes);
    SecurePrint.log("##### YoutubeVideo #####");
  }

}