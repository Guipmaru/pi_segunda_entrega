import 'package:pi_segunda_entrega/data/database_helper.dart';
import 'package:pi_segunda_entrega/models/user_profile_model.dart';

class ProfileController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> updateUserProfile(int userId, UserProfile profile) async {
    await _dbHelper.updateUserProfile(userId, profile.toMap());
  }

  Future<UserProfile?> getUserProfile(int userId) async {
    var profileMap = await _dbHelper.getUserProfile(userId);
    if (profileMap != null) {
      return UserProfile.fromMap(profileMap);
    }
    return null;
  }
}