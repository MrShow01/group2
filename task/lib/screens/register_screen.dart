import 'package:flutter/material.dart';
import 'package:task/services/auth_service.dart';
import 'package:task/utils/app_routes.dart';
import 'package:task/widgets/custom_button.dart';
import 'package:task/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _isGradeController = TextEditingController();
  final TextEditingController _csGradeController = TextEditingController();
  final TextEditingController _tsGradeController = TextEditingController();
  final TextEditingController _itGradeController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _isGradeController.dispose();
    _csGradeController.dispose();
    _tsGradeController.dispose();
    _itGradeController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final name = _nameController.text.trim();
    final itGrade = _itGradeController.text.trim();
    final csGrade = _csGradeController.text.trim();
    final isGrade = _isGradeController.text.trim();
    final tsGrade = _tsGradeController.text.trim();

    if ([
      email,
      password,
      confirmPassword,
      name,
      itGrade,
      csGrade,
      isGrade,
      tsGrade,
    ].any((field) => field.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // if (!_agreeToTerms) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please agree to the Terms & Conditions first'),
    //     ),
    //   );
    //   return;
    // }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authService.register(
      email: email,
      password: password,
      name: name,
      itGrade: itGrade,
      csGrade: csGrade,
      isGrade: isGrade,
      tsGrade: tsGrade,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result ?? 'Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
            vertical: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Create Account ✨',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Join our community and start sharing tools',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.06),

              // ---------- Input Fields ----------
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
                inputType: TextInputType.emailAddress,
              ),
              _buildPasswordField(
                controller: _passwordController,
                hintText: 'Password',
                obscure: _obscurePassword,
                toggle: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              _buildPasswordField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscure: _obscureConfirm,
                toggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              _buildTextField(
                controller: _nameController,
                hintText: 'Full Name',
                icon: Icons.person_outline,
              ),
              _buildTextField(
                controller: _itGradeController,
                hintText: 'IT Grade',
                icon: Icons.grade_outlined,
                inputType: TextInputType.number,
              ),
              _buildTextField(
                controller: _csGradeController,
                hintText: 'CS Grade',
                icon: Icons.grade_outlined,
                inputType: TextInputType.number,
              ),
              _buildTextField(
                controller: _isGradeController,
                hintText: 'IS Grade',
                icon: Icons.grade_outlined,
                inputType: TextInputType.number,
              ),
              _buildTextField(
                controller: _tsGradeController,
                hintText: 'TS Grade',
                icon: Icons.grade_outlined,
                inputType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              // ---------- Sign Up Button ----------
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: "Sign Up", onPressed: _signUp),

              const SizedBox(height: 28),

              // ---------- Already Have Account ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
      padding: const EdgeInsets.only(bottom: 16),
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
