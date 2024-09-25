class QuoteModel {
  int id;
  String quote;
  String author;

  QuoteModel({required this.id, required this.quote, required this.author});

  /// Map(JSON) -> Model
  //fromJson
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
        id: json['id'], quote: json['quote'], author: json['author']);
  }
}

class QuoteDataModel {
  int limit;
  int skip;
  int total;
  List<QuoteModel> quotes;

  QuoteDataModel(
      {required this.limit,
      required this.skip,
      required this.total,
      required this.quotes});

  factory QuoteDataModel.fromJson(Map<String, dynamic> json) {

    List<QuoteModel> mQuotes = [];

    for(Map<String, dynamic> eachQuote in json['quotes']){
      var eachQuoteModel = QuoteModel.fromJson(eachQuote);
      mQuotes.add(eachQuoteModel);
    }

    return QuoteDataModel(
        limit: json['limit'],
        skip: json['skip'],
        total: json['total'],
        quotes: mQuotes);
  }
}
