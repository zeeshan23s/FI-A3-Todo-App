import '../../packages_export.dart';

part 'forms/todo_login_form.dart';
part 'forms/todo_registration_form.dart';
part 'forms/todo_password_reset_form.dart';

class TodoAuthScreen extends StatelessWidget {
  const TodoAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.screenWidth(context) * 0.02,
              vertical: ScreenHelper.screenHeight(context) * 0.02),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(appLogo, scale: 2),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      child: Text('Let’s Make Event\nManagement Easy',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: ScreenHelper.screenHeight(context) * 0.04),
                    CustomizedButton(
                      onPressed: () => customModelBottomSheet(
                          context, const TodoLoginForm()),
                      child: Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: ScreenHelper.screenHeight(context) * 0.02),
                    CustomizedButton(
                      onPressed: () => customModelBottomSheet(
                          context, const TodoRegistrationForm()),
                      backgroundColor: secondaryColor,
                      child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
