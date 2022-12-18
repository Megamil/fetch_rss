// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:fetch_rss/fetch_rss.dart';

void main() {

  //Simple test
  test('Test video list', () async {
    YoutubeRSSModel? model = await FetchRSSYoutube.fetch("UCLTWPE7XrHEe8m_xAmNbQ-Q");
    expect(model?.channelTitle, isNotNull);
    expect(model?.entryList?.isEmpty, false);
  });

}
