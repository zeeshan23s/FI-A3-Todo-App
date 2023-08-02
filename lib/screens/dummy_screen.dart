import '../packages_export.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.screenWidth(context) * 0.02,
            vertical: ScreenHelper.screenHeight(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Authentication Successful!',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: ScreenHelper.screenHeight(context) * 0.05),
            CustomizedButton(
                backgroundColor: secondaryColor,
                onPressed: () => context.read<AuthProvider>().logout(),
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
