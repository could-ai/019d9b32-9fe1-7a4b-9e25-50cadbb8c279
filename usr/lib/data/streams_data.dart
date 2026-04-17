import '../models/bac_stream.dart';

const List<BacStream> moroccanStreams = [
  BacStream(
    id: 'sm_a',
    name: 'Sciences Mathématiques A',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Arabe', coefficient: 2),
      BacSubject(name: 'Histoire-Géographie', coefficient: 2),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Mathématiques', coefficient: 9),
      BacSubject(name: 'Physique-Chimie', coefficient: 7),
      BacSubject(name: 'Sciences de la Vie et de la Terre', coefficient: 3),
      BacSubject(name: 'Philosophie', coefficient: 2),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 2),
    ],
  ),
  BacStream(
    id: 'sm_b',
    name: 'Sciences Mathématiques B',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Arabe', coefficient: 2),
      BacSubject(name: 'Histoire-Géographie', coefficient: 2),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Mathématiques', coefficient: 9),
      BacSubject(name: 'Physique-Chimie', coefficient: 7),
      BacSubject(name: 'Sciences de l\\'Ingénieur', coefficient: 3),
      BacSubject(name: 'Philosophie', coefficient: 2),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 2),
    ],
  ),
  BacStream(
    id: 'pc',
    name: 'Sciences Physiques',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Arabe', coefficient: 2),
      BacSubject(name: 'Histoire-Géographie', coefficient: 2),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Mathématiques', coefficient: 7),
      BacSubject(name: 'Physique-Chimie', coefficient: 7),
      BacSubject(name: 'Sciences de la Vie et de la Terre', coefficient: 5),
      BacSubject(name: 'Philosophie', coefficient: 2),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 2),
    ],
  ),
  BacStream(
    id: 'svt',
    name: 'Sciences de la Vie et de la Terre',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Arabe', coefficient: 2),
      BacSubject(name: 'Histoire-Géographie', coefficient: 2),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Mathématiques', coefficient: 7),
      BacSubject(name: 'Physique-Chimie', coefficient: 5),
      BacSubject(name: 'Sciences de la Vie et de la Terre', coefficient: 7),
      BacSubject(name: 'Philosophie', coefficient: 2),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 2),
    ],
  ),
  BacStream(
    id: 'eco',
    name: 'Sciences Économiques',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Arabe', coefficient: 2),
      BacSubject(name: 'Histoire-Géographie', coefficient: 2),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Economie Générale', coefficient: 6),
      BacSubject(name: 'Comptabilité', coefficient: 4),
      BacSubject(name: 'Economie et Organisation', coefficient: 3),
      BacSubject(name: 'Mathématiques', coefficient: 4),
      BacSubject(name: 'Philosophie', coefficient: 2),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 2),
    ],
  ),
  BacStream(
    id: 'lettres',
    name: 'Lettres',
    regionalSubjects: [
      BacSubject(name: 'Français', coefficient: 4),
      BacSubject(name: 'Mathématiques', coefficient: 1),
      BacSubject(name: 'Education Islamique', coefficient: 2),
    ],
    nationalSubjects: [
      BacSubject(name: 'Arabe', coefficient: 4),
      BacSubject(name: 'Philosophie', coefficient: 4),
      BacSubject(name: 'Histoire-Géographie', coefficient: 4),
      BacSubject(name: 'Langue Etrangère 2', coefficient: 3),
    ],
  ),
];
