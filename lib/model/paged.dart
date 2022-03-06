class Paged<T> {
  final List<T> results;
  final int totalCount;
  const Paged({required this.results, required this.totalCount});

  factory Paged.fromMap(Map<String, dynamic> data, Function mapper) {
    final results = data['results'] as List<dynamic>;
    return Paged(
        totalCount: data['count'],
        results: List<T>.from(results.map((e) => mapper(e))));
  }
}
