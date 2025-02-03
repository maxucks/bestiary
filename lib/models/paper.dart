import 'package:bestiary/models/category.dart';
import 'package:equatable/equatable.dart';

class Paper extends Equatable {
  const Paper({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.notes,
    this.originalTitle,
  });

  final int id;
  final String title;
  final String? originalTitle;
  final String description;
  final String imageUrl;
  final Category category;
  final List<String> notes;

  factory Paper.fromJson(Map<String, dynamic> map) => Paper(
        id: map['id'],
        title: map['title'],
        originalTitle: map['original_title'],
        description: map['description'],
        imageUrl: map['image_url'],
        category: Category.fromJson(map['category']),
        notes: map['notes'] as List<String>,
      );

  @override
  List<Object?> get props => [id, title, originalTitle, description, imageUrl, notes];
}
