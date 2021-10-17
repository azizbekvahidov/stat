// import 'package:flutter_infinite_list/models/models.dart';

abstract class CategoryState {
  CategoryState([List props = const []]);
}

class CategoryUninitialized extends CategoryState {
  @override
  String toString() => 'PostUninitialized';
}

class CategoryError extends CategoryState {
  @override
  String toString() => 'PostError';
}

class CategoryLoaded extends CategoryState {
  final List<Map<String, dynamic>> record;
  final bool hasReachedMax;

  CategoryLoaded({
    this.record = const [],
    this.hasReachedMax = false,
  }) : super([record, hasReachedMax]);

  CategoryLoaded copyWith({
    List<Map<String, dynamic>>? record,
    bool? hasReachedMax,
  }) {
    return CategoryLoaded(
      record: record ?? this.record,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${record.length}, hasReachedMax: $hasReachedMax }';
}
