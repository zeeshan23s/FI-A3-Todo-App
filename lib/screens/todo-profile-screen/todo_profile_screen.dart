import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import '../../packages_export.dart';

class TodoProfileScreen extends StatefulWidget {
  const TodoProfileScreen({super.key});

  @override
  State<TodoProfileScreen> createState() => _TodoProfileScreenState();
}

class _TodoProfileScreenState extends State<TodoProfileScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: primaryColor),
              onPressed: () => Navigator.pop(context)),
          title: Text('Profile',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: primaryColor, fontWeight: FontWeight.w600)),
          backgroundColor: secondaryColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenHelper.screenHeight(context) * 0.02,
              horizontal: ScreenHelper.screenWidth(context) * 0.04),
          child: StreamBuilder(
              stream: UserController.read(
                  AuthController.firebaseAuth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            snapshot.data!['imageURL'] == null
                                ? CircleAvatar(
                                    radius: ScreenHelper.screenHeight(context) *
                                        0.1,
                                    child: Image.asset(defaultProfilePic),
                                  )
                                : CircleAvatar(
                                    radius: ScreenHelper.screenHeight(context) *
                                        0.1,
                                    foregroundImage: NetworkImage(
                                        snapshot.data!['imageURL']),
                                  ),
                            Positioned(
                              bottom:
                                  ScreenHelper.screenHeight(context) * 0.005,
                              right: ScreenHelper.screenWidth(context) * 0.02,
                              child: GestureDetector(
                                onTap: () async {
                                  final XFile? pickedImage = await picker
                                      .pickImage(source: ImageSource.gallery);

                                  if (pickedImage != null) {
                                    final Uint8List image =
                                        await pickedImage.readAsBytes();
                                    String imageURL =
                                        await UserController.uploadImage(
                                            image, snapshot.data!['name']);
                                    UserController.updateImageURL(
                                        AuthController
                                            .firebaseAuth.currentUser!.uid,
                                        imageURL);
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: ScreenHelper.screenHeight(context) *
                                      0.025,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        ScreenHelper.screenHeight(context) *
                                            0.01),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.05),
                      CustomizedTextField(
                        controller:
                            TextEditingController(text: snapshot.data!['name']),
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.person),
                        readOnly: true,
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.02),
                      CustomizedTextField(
                        controller: TextEditingController(
                            text: snapshot.data!['email']),
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.person),
                        readOnly: true,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
