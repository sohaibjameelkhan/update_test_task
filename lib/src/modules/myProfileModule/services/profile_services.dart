import '../models/user_profile_model.dart';

abstract class ProfileServices {
  Future<UserProfileModel?> getUserProfileRequest();
}
