import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_text_form_field.dart';
import 'package:todo/pages/register_view/register_view.dart';

class LoginView extends StatefulWidget {
  static const String routeName = 'login-view';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
          title: Text('Login', style: theme.textTheme.titleLarge),
          centerTitle: true,
          toolbarHeight: 120,
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
                  Text(
                    'Welcome Back!',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: theme.colorScheme.onSecondary),
                  ),
                  const SizedBox(height: 40),
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
                    title: 'Enter your password',
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
                        return 'invalid password';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget password ?',
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.colorScheme.onSecondary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  MaterialButton(
                    onPressed: () {
                      login();
                    },
                    height: 50,
                    color: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Login',
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
                        Navigator.pushNamed(context, RegisterView.routeName);
                      },
                      child: Text(
                        'OR Create new account !',
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

  login() async {
    if(formKey.currentState!.validate()){

      // call login api
      try {

        var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

      } on FirebaseAuthException catch (e) {

        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if(e.code == 'invalid-login-credentials') {
          print("User doesn't exit");
        }
      }
    }
  }
}
