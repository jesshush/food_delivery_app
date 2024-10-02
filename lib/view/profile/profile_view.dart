import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../more/my_order_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtFeedback = TextEditingController();
  TextEditingController txtSuggestions = TextEditingController();
  bool _receiveNotifications = false;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName.text = prefs.getString('name') ?? '';
      txtEmail.text = prefs.getString('email') ?? '';
      txtMobile.text = prefs.getString('mobile') ?? '';
      txtFeedback.text = prefs.getString('feedback') ?? '';
      txtSuggestions.text = prefs.getString('suggestions') ?? '';
      _receiveNotifications = prefs.getBool('receiveNotifications') ?? false;
    });
  }

  Future<void> saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', txtName.text);
    prefs.setString('email', txtEmail.text);
    prefs.setString('mobile', txtMobile.text);
    prefs.setString('feedback', txtFeedback.text);
    prefs.setString('suggestions', txtSuggestions.text);
    prefs.setBool('receiveNotifications', _receiveNotifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile FORM",
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyOrderView(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: TColor.placeholder,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    File(image!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(
                  Icons.person,
                  size: 65,
                  color: TColor.secondaryText,
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: TColor.primary,
                  size: 12,
                ),
                label: Text(
                  "Add image",
                  style: TextStyle(color: TColor.primary, fontSize: 12),
                ),
              ),
              Text(
                "Hi there Jesica!",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: "Name",
                  hintText: "Enter Name",
                  controller: txtName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: "Email",
                  hintText: "Enter Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: "Feedback",
                  hintText: "Enter Feedback",
                  controller: txtFeedback,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: "Suggestions",
                  hintText: "Write your suggestions",
                  controller: txtSuggestions,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Do you want to receive Notifications?",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: _receiveNotifications,
                          onChanged: (value) {
                            setState(() {
                              _receiveNotifications = value as bool;
                              saveProfileData(); // Save when value changes
                            });
                          },
                        ),
                        Text('Yes'),
                        Radio(
                          value: false,
                          groupValue: _receiveNotifications,
                          onChanged: (value) {
                            setState(() {
                              _receiveNotifications = value as bool;
                              saveProfileData(); // Save when value changes
                            });
                          },
                        ),
                        Text('No'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButton(
                  title: "Save",
                  onPressed: () {
                    saveProfileData(); // Save when button is pressed
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
