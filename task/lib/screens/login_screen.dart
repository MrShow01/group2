import 'package:flutter/material.dart';
import 'package:task/services/auth_service.dart';
import 'package:task/utils/app_routes.dart';
import 'package:task/widgets/custom_button.dart';
import 'package:task/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authService.login(email, password);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result == 'success') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful!')));
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result ?? 'Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
            vertical: size.height * 0.06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    const Text(
                      'Welcome Back 👋',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to continue your journey',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.07),

              // ---------- Email ----------
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
                inputType: TextInputType.emailAddress,
              ),

              // ---------- Password ----------
              _buildPasswordField(
                controller: _passwordController,
                hintText: 'Password',
                obscure: _obscurePassword,
                toggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),

              // ---------- Forgot Password ----------
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to forgot password screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // ---------- Sign In Button ----------
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: 'Sign In', onPressed: _signIn),

              SizedBox(height: size.height * 0.04),

              // ---------- Divider ----------
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.04),

              // ---------- Sign Up ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Helper Widgets ----------
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: CustomTextFormField(
        controller: controller,
        hintText: hintText,
        textInputType: inputType,
        prefixIcon: Icon(icon, color: Colors.deepPurple.shade300),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextFormField(
        controller: controller,
        hintText: hintText,
        obscureText: obscure,
        textInputType: TextInputType.visiblePassword,
        prefixIcon: Icon(Icons.lock_outline, color: Colors.deepPurple.shade300),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.deepPurple.shade300,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}
