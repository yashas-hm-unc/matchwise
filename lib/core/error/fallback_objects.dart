import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/important_date.dart';
import 'package:matchwise/core/models/student_user.dart';
import 'package:matchwise/providers/match_provider.dart';

final List<FacultyUser> facultyFallback = [
  FacultyUser(
    firstName: 'John',
    lastName: 'Doe',
    onyen: 'jdoe',
    email: 'john.doe@cs.unc.edu',
    researchInterests: [
      'Machine Learning',
      'Natural Language Processing',
    ],
    positionsOpen: 3,
    courses: [
      'COMP 521',
      'COMP 522',
    ],
  ),
  FacultyUser(
    firstName: 'Alice',
    lastName: 'Smith',
    onyen: 'asmith',
    email: 'alice.smith@cs.unc.edu',
    researchInterests: [
      'Computer Vision',
      'Robotics',
      'Embedded Systems',
    ],
    positionsOpen: 1,
    courses: [
      'COMP 523',
      'COMP 524',
      'COMP 550',
    ],
  ),
  FacultyUser(
    firstName: 'Michael',
    lastName: 'Johnson',
    onyen: 'mjohnson',
    email: 'michael.johnson@cs.unc.edu',
    researchInterests: [
      'Data Mining',
      'Human-Computer Interaction',
      'Cybersecurity',
    ],
    positionsOpen: 4,
    courses: [
      'COMP 530',
      'COMP 540',
    ],
  ),
  FacultyUser(
    firstName: 'Emily',
    lastName: 'Brown',
    onyen: 'ebrown',
    email: 'emily.brown@cs.unc.edu',
    researchInterests: [
      'Bioinformatics',
    ],
    positionsOpen: 2,
    courses: [
      'COMP 550',
      'COMP 580',
    ],
  ),
  FacultyUser(
    firstName: 'David',
    lastName: 'Williams',
    onyen: 'dwilliams',
    email: 'david.williams@cs.unc.edu',
    researchInterests: [
      'Artificial Intelligence',
      'Ethics in AI',
      'Algorithm Design',
    ],
    positionsOpen: 3,
    courses: [
      'COMP 590',
      'COMP 580',
      'COMP 575',
    ],
  ),
  FacultyUser(
    firstName: 'Jessica',
    lastName: 'Taylor',
    onyen: 'jtaylor',
    email: 'jessica.taylor@cs.unc.edu',
    researchInterests: [
      'Quantum Computing',
      'Computational Biology',
    ],
    positionsOpen: 1,
    courses: [
      'COMP 550',
      'COMP 575',
    ],
  ),
  FacultyUser(
    firstName: 'Chris',
    lastName: 'Miller',
    onyen: 'cmiller',
    email: 'chris.miller@cs.unc.edu',
    researchInterests: [
      'Augmented Reality',
      'Virtual Reality',
      'Computer Graphics',
    ],
    positionsOpen: 4,
    courses: [
      'COMP 580',
      'COMP 590',
    ],
  ),
  FacultyUser(
    firstName: 'Sarah',
    lastName: 'Davis',
    onyen: 'sdavis',
    email: 'sarah.davis@cs.unc.edu',
    researchInterests: [
      'Distributed Systems',
      'Blockchain',
    ],
    positionsOpen: 2,
    courses: [
      'COMP 521',
      'COMP 522',
    ],
  ),
  FacultyUser(
    firstName: 'Daniel',
    lastName: 'Wilson',
    onyen: 'dwilson',
    email: 'daniel.wilson@cs.unc.edu',
    researchInterests: [
      'Cloud Computing',
      'Data Science',
    ],
    positionsOpen: 3,
    courses: [
      'COMP 550',
      'COMP 540',
    ],
  ),
  FacultyUser(
    firstName: 'Laura',
    lastName: 'Moore',
    onyen: 'lmoore',
    email: 'laura.moore@cs.unc.edu',
    researchInterests: [
      'Network Security',
      'Cryptography',
      'Privacy',
    ],
    positionsOpen: 2,
    courses: [
      'COMP 590',
      'COMP 575',
    ],
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

final List<StudentUser> studentsFallback = [
  StudentUser(
    firstName: 'Alex',
    lastName: 'Green',
    onyen: 'agreen',
    email: 'agreen@cs.unc.edu',
    courseTAPref: [
      'COMP 521',
      'COMP 550',
    ],
    researchInterests: [
      'Machine Learning',
      'Natural Language Processing',
    ],
    prefProfessors: [
      'John Doe',
      'Michael Johnson',
    ],
    description:
        'Aspiring ML researcher with a focus on NLP. Looking for opportunities to contribute to innovative projects.',
    resumeLink: 'https://resume.com/agreen',
    videoLink: 'https://video.com/agreen',
  ),
  StudentUser(
    firstName: 'Ben',
    lastName: 'Taylor',
    onyen: 'btaylor',
    email: 'btaylor@cs.unc.edu',
    courseTAPref: [
      'COMP 562',
      'COMP 590',
    ],
    researchInterests: [
      'Computer Vision',
      'Robotics',
      'Embedded Systems',
    ],
    prefProfessors: [
      'Alice Smith',
      'Chris Miller',
    ],
    description:
        'Passionate about computer vision and robotics, with experience in embedded systems.',
    resumeLink: 'https://resume.com/btaylor',
    videoLink: 'https://video.com/btaylor',
  ),
  StudentUser(
    firstName: 'Chloe',
    lastName: 'Miller',
    onyen: 'cmiller',
    email: 'cmiller@cs.unc.edu',
    courseTAPref: [
      'COMP 530',
      'COMP 575',
    ],
    researchInterests: [
      'Human-Computer Interaction',
      'Data Mining',
      'Cybersecurity',
    ],
    prefProfessors: [
      'Michael Johnson',
      'Laura Moore',
    ],
    description:
        'Interested in HCI, data mining, and cybersecurity, eager to work on impactful projects.',
    resumeLink: 'https://resume.com/cmiller',
    videoLink: 'https://video.com/cmiller',
  ),
  StudentUser(
    firstName: 'Daniel',
    lastName: 'Young',
    onyen: 'dyoung',
    email: 'dyoung@cs.unc.edu',
    courseTAPref: [
      'COMP 590',
      'COMP 555',
    ],
    researchInterests: [
      'Bioinformatics',
      'Computational Biology',
    ],
    prefProfessors: [
      'Emily Brown',
      'Jessica Taylor',
    ],
    description:
        'Bioinformatics and computational biology enthusiast with a strong analytical background.',
    resumeLink: 'https://resume.com/dyoung',
    videoLink: 'https://video.com/dyoung',
  ),
  StudentUser(
    firstName: 'Ella',
    lastName: 'Scott',
    onyen: 'escott',
    email: 'escott@cs.unc.edu',
    courseTAPref: [
      'COMP 560',
      'COMP 524',
    ],
    researchInterests: [
      'Artificial Intelligence',
      'Ethics in AI',
      'Algorithm Design',
    ],
    prefProfessors: [
      'David Williams',
      'John Doe',
    ],
    description:
        'Focused on AI and ethics, with a goal to contribute to responsible AI development.',
    resumeLink: 'https://resume.com/escott',
    videoLink: 'https://video.com/escott',
  ),
  StudentUser(
    firstName: 'Frank',
    lastName: 'King',
    onyen: 'fking',
    email: 'fking@cs.unc.edu',
    courseTAPref: [
      'COMP 581',
      'COMP 550',
    ],
    researchInterests: [
      'Quantum Computing',
      'Computational Biology',
    ],
    prefProfessors: [
      'Jessica Taylor',
      'Emily Brown',
    ],
    description:
        'Dedicated to exploring the intersection of quantum computing and biology.',
    resumeLink: 'https://resume.com/fking',
    videoLink: 'https://video.com/fking',
  ),
  StudentUser(
    firstName: 'Grace',
    lastName: 'Adams',
    onyen: 'gadams',
    email: 'gadams@cs.unc.edu',
    courseTAPref: [
      'COMP 555',
      'COMP 523',
    ],
    researchInterests: [
      'Augmented Reality',
      'Virtual Reality',
      'Computer Graphics',
    ],
    prefProfessors: [
      'Chris Miller',
      'Alice Smith',
    ],
    description:
        'AR/VR enthusiast with a passion for immersive technology and user experience.',
    resumeLink: 'https://resume.com/gadams',
    videoLink: 'https://video.com/gadams',
  ),
  StudentUser(
    firstName: 'Henry',
    lastName: 'Evans',
    onyen: 'hevans',
    email: 'hevans@cs.unc.edu',
    courseTAPref: [
      'COMP 580',
      'COMP 560',
    ],
    researchInterests: [
      'Distributed Systems',
      'Blockchain',
    ],
    prefProfessors: [
      'Sarah Davis',
      'David Williams',
    ],
    description:
        'Interested in distributed computing and blockchain, with a focus on scalable systems.',
    resumeLink: 'https://resume.com/hevans',
    videoLink: 'https://video.com/hevans',
  ),
  StudentUser(
    firstName: 'Isabella',
    lastName: 'Perez',
    onyen: 'iperez',
    email: 'iperez@cs.unc.edu',
    courseTAPref: [
      'COMP 521',
      'COMP 590',
    ],
    researchInterests: [
      'Cloud Computing',
      'Data Science',
    ],
    prefProfessors: [
      'Daniel Wilson',
      'Michael Johnson',
    ],
    description:
        'Data science enthusiast aiming to leverage cloud computing for large-scale data analysis.',
    resumeLink: 'https://resume.com/iperez',
    videoLink: 'https://video.com/iperez',
  ),
  StudentUser(
    firstName: 'Jack',
    lastName: 'Morgan',
    onyen: 'jmorgan',
    email: 'jmorgan@cs.unc.edu',
    courseTAPref: [
      'COMP 555',
      'COMP 550',
    ],
    researchInterests: [
      'Network Security',
      'Cryptography',
      'Privacy',
    ],
    prefProfessors: [
      'Laura Moore',
      'Michael Johnson',
    ],
    description:
        'Committed to advancing network security and privacy through cryptography.',
    resumeLink: 'https://resume.com/jmorgan',
    videoLink: 'https://video.com/jmorgan',
  ),
];

void createdShortlisted(Ref ref){
  Map<String, List<String>> hiringStages = {
    'shortlisted': ['agreen', 'btaylor', 'cmiller', 'fking', 'dyoung'],
    'interviewing': ['agreen', 'jmorgan', 'hevans', 'escott', 'gadams'],
    'finalized': ['btaylor', 'iperez', 'dyoung', 'jmorgan']
  };
  final matches = <String, List<StudentUser>>{};
  for (var i in hiringStages.keys) {
    matches[i] = studentsFallback
        .where((e) => hiringStages[i]!.contains(e.onyen))
        .toList();
  }
  ref.read(sortedProvider.notifier).initDev(matches);
}

void createMatches(Ref ref) {
  Map<String, List<String>> facultyToStudentMatches = {
    'jdoe': ['agreen', 'btaylor', 'cmiller', 'dyoung'],
    'asmith': ['escott', 'gadams', 'hevans'],
    'mjohnson': ['btaylor', 'fking', 'jmorgan'],
    'ebrown': ['dyoung', 'agreen', 'escott'],
    'dwilliams': ['hevans', 'gadams', 'iperez'],
    'jtaylor': ['fking', 'jmorgan', 'btaylor'],
    'cmiller': ['cmiller', 'agreen', 'dyoung'],
    'sdavis': ['iperez', 'jmorgan', 'escott'],
    'dwilson': ['gadams', 'hevans', 'btaylor', 'cmiller'],
    'lmoore': ['agreen', 'dyoung', 'jmorgan']
  };

  final matches = <FacultyUser, List<StudentUser>>{};
  for (var i in facultyToStudentMatches.keys) {
    matches[facultyFallback.firstWhere((e) => e.onyen == i)] = studentsFallback
        .where((e) => facultyToStudentMatches[i]!.contains(e.onyen))
        .toList();
  }
  ref.read(matchedProvider.notifier).initDev(matches);
}
