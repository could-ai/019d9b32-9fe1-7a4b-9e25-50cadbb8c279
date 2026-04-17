class BacStream {
  final String id;
  final String name;
  final List<BacSubject> regionalSubjects;
  final List<BacSubject> nationalSubjects;

  const BacStream({
    required this.id,
    required this.name,
    required this.regionalSubjects,
    required this.nationalSubjects,
  });
}

class BacSubject {
  final String name;
  final int coefficient;

  const BacSubject({
    required this.name,
    required this.coefficient,
  });
}
