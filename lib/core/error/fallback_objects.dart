import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/important_date.dart';

final List<FacultyUser> facultyFallback = [
  FacultyUser(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    pid: '123456789',
    email: 'john.doe@cs.unc.edu',
    researchInterests: ['Machine Learning', 'Natural Language Processing'],
    positionsOpen: 3,
  ),
  FacultyUser(
    id: '2',
    firstName: 'Alice',
    lastName: 'Smith',
    pid: '234567891',
    email: 'alice.smith@cs.unc.edu',
    researchInterests: [
      'Computer Vision',
      'Robotics',
      'Embedded Systems',
    ],
    positionsOpen: 1,
  ),
  FacultyUser(
    id: '3',
    firstName: 'Michael',
    lastName: 'Johnson',
    pid: '345678912',
    email: 'michael.johnson@cs.unc.edu',
    researchInterests: [
      'Data Mining',
      'Human-Computer Interaction',
      'Cybersecurity',
    ],
    positionsOpen: 4,
  ),
  FacultyUser(
    id: '4',
    firstName: 'Emily',
    lastName: 'Brown',
    pid: '456789123',
    email: 'emily.brown@cs.unc.edu',
    researchInterests: [
      'Bioinformatics',
    ],
    positionsOpen: 2,
  ),
  FacultyUser(
    id: '5',
    firstName: 'David',
    lastName: 'Williams',
    pid: '567891234',
    email: 'david.williams@cs.unc.edu',
    researchInterests: [
      'Artificial Intelligence',
      'Ethics in AI',
      'Algorithm Design',
    ],
    positionsOpen: 3,
  ),
  FacultyUser(
    id: '6',
    firstName: 'Jessica',
    lastName: 'Taylor',
    pid: '678912345',
    email: 'jessica.taylor@cs.unc.edu',
    researchInterests: [
      'Quantum Computing',
      'Computational Biology',
    ],
    positionsOpen: 1,
  ),
  FacultyUser(
    id: '7',
    firstName: 'Chris',
    lastName: 'Miller',
    pid: '789123456',
    email: 'chris.miller@cs.unc.edu',
    researchInterests: [
      'Augmented Reality',
      'Virtual Reality',
      'Computer Graphics',
    ],
    positionsOpen: 4,
  ),
  FacultyUser(
    id: '8',
    firstName: 'Sarah',
    lastName: 'Davis',
    pid: '891234567',
    email: 'sarah.davis@cs.unc.edu',
    researchInterests: [
      'Distributed Systems',
      'Blockchain',
    ],
    positionsOpen: 2,
  ),
  FacultyUser(
    id: '9',
    firstName: 'Daniel',
    lastName: 'Wilson',
    pid: '912345678',
    email: 'daniel.wilson@cs.unc.edu',
    researchInterests: [
      'Cloud Computing',
      'Data Science',
    ],
    positionsOpen: 3,
  ),
  FacultyUser(
    id: '10',
    firstName: 'Laura',
    lastName: 'Moore',
    pid: '123456780',
    email: 'laura.moore@cs.unc.edu',
    researchInterests: [
      'Network Security',
      'Cryptography',
      'Privacy',
    ],
    positionsOpen: 2,
  ),
];

final List<ImportantDate> importantDatesFallback = [
  ImportantDate(
    id: 'positions',
    title: 'Positions open broadcast deadline',
    date: DateTime(2025, 7, 20, 23, 59, 59),
    requiredDate: true,
  ),
  ImportantDate(
    id: 'question_deadline',
    requiredDate: true,
    title: 'Faculty questionnaire addition deadline',
    date: DateTime(2025, 7, 27, 23, 59, 59),
  ),
  ImportantDate(
    id: 'form_deadline',
    requiredDate: true,
    title: 'Student form filling deadline',
    date: DateTime(2025, 8, 3, 23, 59, 59),
  ),
  ImportantDate(
    id: 'sorting_deadline',
    requiredDate: true,
    title: 'Faculty student shortlisting deadline',
    date: DateTime(2025, 8, 10, 23, 59, 59),
  ),
  ImportantDate(
    id: 'interview_deadline',
    requiredDate: true,
    title: 'Student interviews and selection deadline',
    date: DateTime(2025, 8, 17, 23, 59, 59),
  ),
  ImportantDate(
    id: 'final_decision',
    requiredDate: true,
    title: 'Final Decisions',
    date: DateTime(2025, 8, 24, 23, 59, 59),
  ),
];
