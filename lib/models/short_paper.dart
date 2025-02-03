import 'package:equatable/equatable.dart';

class ShortPaper extends Equatable {
  const ShortPaper({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final int id;
  final String title;
  final String imageUrl;

  factory ShortPaper.fromJson(Map<String, dynamic> map) => ShortPaper(
        id: map['id'],
        title: map['title'],
        imageUrl: map['image_url'],
      );

  @override
  List<Object?> get props => [id, title, imageUrl];
}
