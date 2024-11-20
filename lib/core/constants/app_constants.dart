const String appName = 'MatchWise';

const String homeRoute = '/';

const String loginRoute = '/login';

const String heroTag = 'singleHero';

const String kEmptyString = '';

final List<String> facultyNavigation = [
  'Dashboard',
  'Important Dates',
  'Edit Matching Parameters',
  // 'Add Questions'
];

final List<String> facultyNavIcons = [
  dashboardAsset,
  timelineAsset,
  editPreferencesAsset,
  editFormAsset,
];

final List<String> studentNavigation = [
  'Dashboard',
  'Important Dates',
  'Matching Form'
];

final List<String> studentNavIcons = [
  dashboardAsset,
  timelineAsset,
  formAsset,
];

final List<String> adminNavigation = [
  'Dashboard',
  'Switch Students',
  'Modify Faculty Users',
  'Set Important Dates',
];

final List<String> adminNavIcons = [
  dashboardAsset,
  switchMatchesAsset,
  addFacultyAsset,
  timelineAsset,
];

final List<String> settingsPopup = [
  // 'Settings',
  'Profile',
  'Logout',
];

final List<String> keys = [
  'shortlisted',
  'interviewing',
  'finalized',
];

const String logoAsset = 'assets/images/logo.svg';

const String googleAsset = 'assets/images/icons/google.svg';

const String dashboardAsset = 'assets/images/dashboard.svg';

const String editFormAsset = 'assets/images/edit_form.svg';

const String editPreferencesAsset = 'assets/images/edit_preferences.svg';

const String editTimelineAsset = 'assets/images/edit_timeline.svg';

const String formAsset = 'assets/images/form.svg';

const String switchMatchesAsset = 'assets/images/switch_matches.svg';

const String timelineAsset = 'assets/images/timeline.svg';

const String addFacultyAsset = 'assets/images/add_faculty.svg';

const String backAsset = 'assets/images/icons/back.svg';

const loginScreenText =
    'Please sign in using your\n<onyen>@cs.unc.edu\nemail address.';

const loginScreenBtnText = 'Login using';

const String userCollection = 'users';

const String metadataFirestore = 'metadata';

const String matchCollection = 'matching';

const String sortedCollection = 'sorted';

const String impDatesCollection = 'important_dates';
