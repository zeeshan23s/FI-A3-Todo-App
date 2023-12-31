import '../../../packages_export.dart';

class TodoLoginForm extends StatefulWidget {
  const TodoLoginForm({super.key});

  @override
  State<TodoLoginForm> createState() => _TodoLoginFormState();
}

class _TodoLoginFormState extends State<TodoLoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login to your account',
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
                          height: ScreenHelper.screenHeight(context) * 0.008),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          CustomizedModelSheets.bottomSheet(
                            context,
                            const TodoPasswordResetForm(),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Forgot password? ',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Click here',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.03),
                      CustomizedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<AuthProvider>()
                                .login(_emailController.text,
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
                                          ?.copyWith(color: primaryColor)),
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
                          'Login',
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
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      CustomizedModelSheets.bottomSheet(
                          context, const TodoRegistrationForm());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
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
