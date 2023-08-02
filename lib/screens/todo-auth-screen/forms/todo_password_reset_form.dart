part of '../todo_auth_screen.dart';

class TodoPasswordResetForm extends StatefulWidget {
  const TodoPasswordResetForm({super.key});

  @override
  State<TodoPasswordResetForm> createState() => _TodoPasswordResetFormState();
}

class _TodoPasswordResetFormState extends State<TodoPasswordResetForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

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
                            'Forgot Password',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reset your account password',
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
                            height: ScreenHelper.screenHeight(context) * 0.03),
                        CustomizedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await AuthController.sendPasswordResetEmail(
                                      _emailController.text)
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
                            'Reset Password',
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
                        customModelBottomSheet(context, const TodoLoginForm());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Remember your password? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w400),
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
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
