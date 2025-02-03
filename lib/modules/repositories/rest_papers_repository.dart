import 'package:bestiary/models/paper.dart';
import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';

class RestPapersRepository implements PapersRepository {
  final HttpAdapter source;

  const RestPapersRepository(this.source);

  @override
  Future<List<ShortPaper>> getPapers(int categoryId) async {
    final raw = await source.get('/papers') as List<Map<String, dynamic>>;
    final papers = raw.map(ShortPaper.fromJson);
    return papers.toList();
  }

  @override
  Future<Paper> getPaper(int id) async {
    final raw = await source.get('/paper');
    final paper = Paper.fromJson(raw);
    return paper;
  }
}
