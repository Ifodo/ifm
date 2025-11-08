


class WFTListItem {
  String? imageUrl;
  String? date;
  String? content;
  String? title;
  String? url;

  WFTListItem({
    this.imageUrl,
    this.date,
    this.content,
    this.title,
    this.url
  });

  factory WFTListItem.fromJSON(Map<String, dynamic> json) {
    return WFTListItem(
        imageUrl: json["image"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        url: json["link"]
    );
  }
}

