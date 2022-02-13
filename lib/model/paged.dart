class Paged<T> {
  final List<T> results;
  final int count;

  const Paged({required this.results, required this.count});

  factory Paged.fromMap(Map<String, dynamic> data, Function mapper) {
    var results = data['results'] as List<dynamic>;
    return Paged(
        count: data['count'],
        results: List<T>.from(results.map((e) => mapper(e))));
  }
}
