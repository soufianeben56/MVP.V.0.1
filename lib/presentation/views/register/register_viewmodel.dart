import 'package:infinity_circuit/exports.dart';

class RegisterViewModel extends LocalBaseModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool _isPassVisibility = false;
  bool get isPassVisibility => _isPassVisibility;

  void togglePasswordVisibility() {
    _isPassVisibility = !_isPassVisibility;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    // Access the text from the controllers
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validations
    if (name.isEmpty) {
      showSnackBar(message: "Name cannot be empty");
      return;
    }
    if (email.isEmpty) {
      showSnackBar(message: "Email cannot be empty");
      return;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      showSnackBar(message: "Enter a valid email address");
      return;
    }
    if (password.isEmpty) {
      showSnackBar(message: "Password cannot be empty");
      return;
    } else if (password.length < 6) {
      showSnackBar(message: "Password must be at least 6 characters long");
      return;
    }

    // Save registration details
    String? result = await saveRegistrationDetails();
    if (result == null) {
      showSnackBar(message: "Registered successfully");

      // Navigate after saving details
      navigateTo(RoutePaths.safetyViewRoute);
    } else {
      showSnackBar(message: result); // Display specific error message
    }
  }

  // Helper function to show a snackbar message
  Future<String?> saveRegistrationDetails() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Check if the name or email already exists
    List<String> existingNames = await _getExistingNames();
    List<String> existingEmails = await _getExistingEmails();

    if (existingEmails.contains(email)) {
      return "This email is already in use";
    }

    if (existingNames.contains(name)) {
      return "This name is already in use";
    }

    // Save details to UserPreference
    try {
      await UserPreference.getInstance();
      List<String> allNames = existingNames
        ..add(name); // Add new name to existing names
      List<String> allEmails = existingEmails
        ..add(email); // Add new email to existing emails

      await UserPreference.putString(PrefKeys.name, name);
      await UserPreference.putString(PrefKeys.email, email);
      await UserPreference.putString(PrefKeys.password, password);
      await UserPreference.putBool(PrefKeys.isLogin, true);
      return null; // Success
    } catch (e) {
      // Handle the error and return failure message
      print('Error saving registration details: $e');
      return "Failed to save registration details";
    }
  }

  Future<List<String>> _getExistingNames() async {
    await UserPreference.getInstance();
    // Fetch the existing names
    String? names = UserPreference.getString(
        PrefKeys.name); // Retrieve names from UserPreference
    return names?.split(',') ?? [];
  }

  Future<List<String>> _getExistingEmails() async {
    await UserPreference.getInstance();
    // Fetch the existing emails
    String? emails = UserPreference.getString(PrefKeys.email);
    log(emails.toString(),
        name: 'emailreg'); // Retrieve emails from UserPreference
    return emails?.split(',') ?? [];
  }

  void onTapLog() {
    back();
  }

  String? registeredName;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
