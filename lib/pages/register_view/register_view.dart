import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/core/services/snackbar_service.dart';

import '../../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = 'register-view';
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isVisible = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        image: const DecorationImage(
          image: AssetImage('assets/images/login_pattern.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Create Account', style: theme.textTheme.titleLarge),
          centerTitle: true,
          toolbarHeight: 120,
          iconTheme: IconThemeData(color: theme.colorScheme.secondary),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.18,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    title: 'Enter your full name',
                    textEditingController: fullNameController,
                    labelText: 'Full Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'You must enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    title: 'Enter your email',
                    textEditingController: emailController,
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'You must enter your e-mail address';
                      }

                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!regex.hasMatch(value)) {
                        return 'invalid e-mail address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    title: 'Must contains A-Z, a-z, @-#-&.. , 1-9',
                    textEditingController: passwordController,
                    labelText: 'Password',
                    obscureText: !isVisible,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                      child: isVisible == true
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'You must enter your password';
                      }

                      var regex = RegExp(
                        r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$",
                      );

                      if (!regex.hasMatch(value)) {
                        return 'Must contains A-Z, a-z, @-#-&.. , 1-9';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    title: 'Re enter your password',
                    textEditingController: confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: !isVisible,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                      child: isVisible == true
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'You must enter your password';
                      }

                      var regex = RegExp(
                        r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$",
                      );

                      if (value != passwordController.text) {
                        return "Passwords doesn't match";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    onPressed: () {
                      register();
                    },
                    height: 50,
                    color: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Up',
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_forward_rounded)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OR Log in !',
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.colorScheme.onSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();

      try {
        // call api to register
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(
            'Your account has been created successfully');

        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {

        if (e.code == 'weak-password') {

          EasyLoading.dismiss();
          SnackBarService.showErrorMessage('The password provided is too weak.');
          print('The password provided is too weak.');

        } else if (e.code == 'email-already-in-use') {

          EasyLoading.dismiss();
          print(e.message);
          SnackBarService.showErrorMessage('The account already exists for that email.');
          print('The account already exists for that email.');

        }
      } catch (e) {
        print(e);
      }
    }
  }
}
