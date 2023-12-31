import 'dart:convert';

import 'package:books_app/models/book.dart';
import 'package:books_app/services/utils.dart';
import 'package:http/http.dart';

class BookSearchUtils {
  static Future<Book> fetchBookById(String id) async {
    final url = 'https://www.googleapis.com/books/v1/volumes/$id';
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    var bookMap = await jsonDecode(response.body);
    return Utils.bookFromJson(bookMap);
  }
}
