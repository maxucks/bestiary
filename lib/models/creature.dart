enum Habitat {
  mountains,
  roadsides,
  water,
  houses,
  wandering,
}

enum Danger {
  high,
  mid,
  low,
  neutral,
}

enum Trait {
  social,
}

class Name {
  const Name({
    required this.local,
    this.original,
  });

  final String local;
  final String? original;
}

class Creature {
  const Creature({
    required this.id,
    required this.name,
    required this.description,
    required this.aliases,
    required this.danger,
    this.imageUrl,
    this.habitat,
    this.traits,
  });

  final int id;
  final Name name;
  final String description;
  final String? imageUrl;
  final List<Name> aliases;
  final Habitat? habitat;
  final List<Trait>? traits;
  final Danger danger;
}

class ListCreature {
  const ListCreature({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  final int id;
  final Name name;
  final String? imageUrl;
}
