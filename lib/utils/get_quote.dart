import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:therapy_hut/utils/quote.dart';

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('https://api.quotable.io/random'));

  if (response.statusCode == 200) {
    return Quote.fromJson(jsonDecode(response.body));
  } else {
    return const Quote(quote: "", author: "");
  }
}
