import '../../packages_export.dart';

class TodoEmailVerificationScreen extends StatelessWidget {
  const TodoEmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.screenWidth(context) * 0.02,
              vertical: ScreenHelper.screenHeight(context) * 0.05),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Almost there!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w900)),
              ),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.12),
              Align(
                alignment: Alignment.center,
                child: Text(
                    'Just follow the link we sent to: ${AuthController.firebaseAuth.currentUser!.email}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.12),
              Icon(Icons.mail_outlined,
                  size: ScreenHelper.screenHeight(context) * 0.1),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.08),
              CustomizedButton(
                  backgroundColor: secondaryColor,
                  onPressed: () async {
                    await OpenMailApp.openMailApp().then((result) => {
                          if (!result.didOpen && !result.canOpen)
                            {showNoMailAppsDialog(context)}
                          else if (!result.didOpen && result.canOpen)
                            {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                },
                              )
                            }
                        });
                  },
                  child: Text(
                    'Open my email app',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                  )),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.025),
              CustomizedButton(
                  onPressed: () => context.read<AuthProvider>().logout(),
                  child: Text(
                    'Logout',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  )),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.025),
              GestureDetector(
                onTap: () {
                  AuthController.sendEmailVerification().whenComplete(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AuthController.status['message'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: primaryColor)),
                        backgroundColor: AuthController.status['code'] == 200
                            ? Colors.green
                            : Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  });
                },
                child: Text(
                  'I did not receive an email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: ScreenHelper.screenHeight(context) * 0.091),
              Text(
                'Note: After Verifying your email. Logout to re-authenticate!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenHelper.screenHeight(context) * 0.012),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
