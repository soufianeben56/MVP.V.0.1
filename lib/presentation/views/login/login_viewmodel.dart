import 'package:infinity_circuit/exports.dart';

class LoginViewModel extends LocalBaseModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPassVisibility = false;
  bool get isPassVisibility => _isPassVisibility;

  void togglePasswordVisibility() {
    _isPassVisibility = !_isPassVisibility;
    notifyListeners();
  }

  void onTapLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Entered Email: $email');
    print('Entered Password: $password');

    if (email.isEmpty) {
      print("Error: Email is empty");
      showSnackBar(message: "Email cannot be empty");
      return;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      print("Error: Invalid email format");
      showSnackBar(message: "Enter a valid email address");
      return;
    }

    if (password.isEmpty) {
      print("Error: Password is empty");
      showSnackBar(message: "Password cannot be empty");
      return;
    } else if (password.length < 6) {
      print("Error: Password is too short");
      showSnackBar(message: "Password must be at least 6 characters long");
      return;
    }

    bool credentialsMatch = await _checkLoginCredentials(email, password);

    if (credentialsMatch) {
      print("Login successful with email: $email");
      showSnackBar(message: "Login successful!");
      await UserPreference.putBool(PrefKeys.isLogin, true);
      redirectWithClearBackStack(RoutePaths.homeViewRoute);
    } else {
      print("Error: Login failed, invalid details or not registered");
      showSnackBar(message: "Invalid Details or Not Registered. Please try again.");
    }
  }

  Future<bool> _checkLoginCredentials(String email, String password) async {
    try {
      await UserPreference.getInstance();
      String? registeredEmail = UserPreference.getString(PrefKeys.email);
      String? registeredPassword = UserPreference.getString(PrefKeys.password);

      print('Stored Email: $registeredEmail');
      print('Stored Password: $registeredPassword');

      if (registeredEmail == email && registeredPassword == password) {
        print("Credentials matched.");
        return true;
      } else {
        print("Credentials did not match.");
      }
    } catch (e) {
      print('Error fetching login details: $e');
    }
    return false;
  }

  void onTapRegi(BuildContext context) {
    print("Navigating to registration page");
    navigateTo(RoutePaths.registerViewRoute);
  }

  @override
  void dispose() {
    print("Disposing controllers");
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
