class Quote {
  final String quote;
  final String author;

  const Quote({
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['content'],
      author: json['author'],
    );
  }
}
