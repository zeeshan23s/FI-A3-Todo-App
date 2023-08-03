import '../../packages_export.dart';

class TodoAddScreen extends StatefulWidget {
  final bool isOld;
  final Task? task;
  const TodoAddScreen({super.key, this.isOld = false, this.task});

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  String _intensity = 'Low';

  bool _hasCompleted = false;

  @override
  void initState() {
    if (widget.isOld) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _intensity = widget.task!.intensity;
      _hasCompleted = widget.task!.isComplete;
    }

    _titleController.addListener(() {});
    _descriptionController.addListener(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: primaryColor),
            onPressed: () => Navigator.pop(context)),
        title: Text(widget.isOld ? 'Update Task' : 'Add Task',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: primaryColor, fontWeight: FontWeight.w600)),
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenHelper.screenHeight(context) * 0.02,
                horizontal: ScreenHelper.screenWidth(context) * 0.04),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title can\'t be null.';
                    }
                    return null;
                  },
                  maxLength: 100,
                  cursorColor: secondaryColor,
                  controller: _titleController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                      counterStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey),
                      hintText: 'Enter the title...',
                      hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                TextFormField(
                  maxLength: 2000,
                  cursorColor: secondaryColor,
                  controller: _descriptionController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                      counterStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey),
                      hintText: 'Enter the description ...',
                      hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                Text('Select Intensity Level',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                CheckboxListTile(
                    title: Text('Low',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: _intensity == 'Low',
                    onChanged: (newStatus) {
                      setState(() {
                        _intensity = 'Low';
                      });
                    }),
                CheckboxListTile(
                    title: Text('Medium',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: _intensity == 'Medium',
                    onChanged: (newStatus) {
                      setState(() {
                        _intensity = 'Medium';
                      });
                    }),
                CheckboxListTile(
                    title: Text('High',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: _intensity == 'High',
                    onChanged: (newStatus) {
                      setState(() {
                        _intensity = 'High';
                      });
                    }),
                Text('Progress Status',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                CheckboxListTile(
                    title: Text('Completed',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: _hasCompleted,
                    onChanged: (newValue) {
                      setState(() {
                        _hasCompleted = newValue!;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (widget.isOld) {
              TaskController.update(Task(
                      id: widget.task!.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      intensity: _intensity,
                      isComplete: _hasCompleted,
                      createdAt: DateTime.now().toString(),
                      uid: AuthController.firebaseAuth.currentUser!.uid))
                  .whenComplete(() {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(TaskController.status['message'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: primaryColor)),
                    backgroundColor: TaskController.status['code'] == 200
                        ? Colors.green
                        : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
            } else {
              TaskController.create(Task(
                      id: '',
                      title: _titleController.text,
                      description: _descriptionController.text,
                      intensity: _intensity,
                      isComplete: _hasCompleted,
                      createdAt: DateTime.now().toString(),
                      uid: AuthController.firebaseAuth.currentUser!.uid))
                  .whenComplete(() {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(TaskController.status['message'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: primaryColor)),
                    backgroundColor: TaskController.status['code'] == 200
                        ? Colors.green
                        : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
            }
          },
          backgroundColor: secondaryColor,
          label: Row(
            children: [
              Icon(widget.isOld ? Icons.edit : Icons.add, color: primaryColor),
              SizedBox(width: ScreenHelper.screenWidth(context) * 0.02),
              Text(widget.isOld ? 'Update' : 'Add',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: primaryColor)),
            ],
          )),
    );
  }
}
