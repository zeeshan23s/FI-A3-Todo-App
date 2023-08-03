import '../../../packages_export.dart';

class TodoRegistrationForm extends StatefulWidget {
  const TodoRegistrationForm({super.key});

  @override
  State<TodoRegistrationForm> createState() => _TodoRegistrationFormState();
}

class _TodoRegistrationFormState extends State<TodoRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;

  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: ScreenHelper.screenHeight(context) * 0.8,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenHelper.screenHeight(context) * 0.04,
                      horizontal: ScreenHelper.screenWidth(context) * 0.04),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Register to a new account',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.03),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be blank';
                            }
                            return null;
                          }),
                          controller: _nameController,
                          labelText: 'Full Name',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.015),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be blank';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Invalid Email';
                            }
                            return null;
                          }),
                          controller: _emailController,
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.015),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be blank';
                            }
                            if (value.length < 8 || value.length > 15) {
                              return 'Invalid Password';
                            }
                            if (value != _confirmPasswordController.text) {
                              return 'Password doesn\'t match!';
                            }
                            return null;
                          }),
                          controller: _passwordController,
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () => setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            }),
                          ),
                          obscureText: !isPasswordVisible,
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.015),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Confirm password can\'t be blank';
                            }
                            if (value.length < 8 || value.length > 15) {
                              return 'Invalid Password';
                            }
                            if (value != _passwordController.text) {
                              return 'Password doesn\'t match!';
                            }
                            return null;
                          }),
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: isConfirmPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () => setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            }),
                          ),
                          obscureText: !isConfirmPasswordVisible,
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.03),
                        CustomizedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<AuthProvider>()
                                  .register(
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text)
                                  .whenComplete(() {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AuthController.status['message'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: primaryColor),
                                    ),
                                    backgroundColor:
                                        AuthController.status['code'] == 200
                                            ? Colors.green
                                            : Colors.red,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              });
                            }
                          },
                          backgroundColor: secondaryColor,
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      CustomizedModelSheets.bottomSheet(
                          context, const TodoLoginForm());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign in',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
