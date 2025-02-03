import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int id;
  final String name;
  final List<String> slug;

  factory Category.fromJson(Map<String, dynamic> map) => Category(
        id: map['id'],
        name: map['name'],
        slug: map['slug'],
      );

  @override
  List<Object?> get props => [id, name, slug];
}
