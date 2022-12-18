# Fetch RSS
This project is a Flutter package developed in Dart that allows you to retrieve a RSS feed and parse it into an object.

## How to use
To use this package, you will need to import it in your Flutter project:
```
import 'package:fetch_rss/src/models/youtube_rss_model.dart';
```

Then, you can retrieve the RSS feed for a specific Youtube channel by calling the fetch method and passing in the channel's id:
```
static String channelId = "YOUR_CHANNEL_ID";
YoutubeRSSModel model = await FetchRSSYoutube.fetch(channelId);
```
The fetch method returns a YoutubeRSSModel object that contains all the information from the RSS feed, including the channel's title, description, and a list of video items.

## Example
Here is an example of how you could use the fetch method to retrieve and display the channel's title and more in your Flutter app:
```
YoutubeRSSModel model = await FetchRSSYoutube.fetch(channelId);

Text(model.channelTitle),
```
You can also iterate through the list of video items to display them in your app:
```
ListView.builder(
    itemCount: model.videos.length,
        itemBuilder: (context, index) {
        return Text(model.videos[index].title);
    },
)
```

# Contributions
If you would like to contribute to this project, please feel free to submit a pull request. We welcome all contributions and suggestions.