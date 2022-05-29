class UserDetailsModel {
  late String _userName;
  late String _userEmail;
  late String _number;
  late String _course;
  late String _selectedPref;

  UserDetailsModel(var userRes) {
    _userName = userRes['name'];
    _userEmail = userRes['_id'];
    _number = userRes['number'];
    _course = userRes['course'];
    _selectedPref = userRes['selected_pref'];
  }

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get numver => _number;
  String get course => _course;
  String get selectedpref => _selectedPref;
}
