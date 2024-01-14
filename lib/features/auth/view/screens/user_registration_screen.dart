import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants_exports.dart';
import '../../../../core/shared/shared_exports.dart';
import '../../../workshop_user/view/validators/validation_util.dart';
import '../../data/models/user_model.dart';
import 'user_login_screen.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();




    final RxBool _obscurePassword = true.obs;
    final RxBool _obscureConfirmPassword = true.obs;



    void showSnackbar(String message) {
      Get.snackbar(
        AppTexts.error, // Title
        message, // Message
        backgroundColor: Colors.white, // Snackbar background color
        colorText: Colors.red, // Text color
        snackPosition: SnackPosition.TOP, // Position of the snackbar
      );
    }

    void registerUser() {
      // if (ValidationUtil.validateEmail(emailController.text) != null) {
      //   showSnackbar(AppTexts.emailEmpty);
      //   return;
      // }
      // if (ValidationUtil.validatePassword(passwordController.text) != null) {
      //   showSnackbar(AppTexts.passwordEmpty);
      //   return;
      // }
      // if (ValidationUtil.validateConfirmPassword(confirmPasswordController.text) != null) {
      //   showSnackbar(AppTexts.confirmPasswordEmpty);
      //   return;
      // }

      final userModel = UserModel(
        id: 'controller.getCurrentUserId()', // Handle ID generation
        email: emailController.text,
        password: passwordController.text, name: '', phoneNumber: '', tireSize: '',
      );

                Get.dialog(const Center(child: AppLoading()));

      // controller.user!.then((result) {
      //   Get.back(); // Close loading dialog
      //   result.fold(
      //     (failure) => Get.snackbar(backgroundColor:Colors.white,colorText:AppColors.dangerColor,
      //         AppTexts.error,  AppTexts.registerationFailed), // Handle failure
      //     (_) => _showSuccessDialog(context), // Handle success
      //   );
      // }).catchError((error) {
      //   Get.back(); // Close loading dialog
      //   Get.snackbar(AppTexts.error, backgroundColor:Colors.white,
      //       AppTexts.registerationFailed); // Handle other errors
      // });
    }

   @override
    void dispose() {
      // Dispose the controllers when the widget is disposed of
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    }

     return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
        backgroundColor:  AppColors.userSecondaryColor ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: AppColors.userPrimaryColor ,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Focus(
                key: _formKey, // Assigning the GlobalKey to the Form
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(AppTexts.createAnAccount, style: Styles.style20White,),SizedBox(height: 50),
                          CustomTextField(
                            controller: emailController,
                            hintText: AppTexts.emailHint,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: ValidationUtil.validateEmail, 
  onClear: () => emailController.clear(),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: passwordController,
                            hintText: AppTexts.passwordHint,
                            prefixIcon: Icons.lock,
      obscureText: _obscurePassword.value, // Use the value of RxBool
  onToggleObscureText: () => _obscurePassword.value = !_obscurePassword.value,

                            // isPassword: true,
                            validator: ValidationUtil.validatePassword,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: confirmPasswordController,
                            hintText: AppTexts.confirmPasswordHint,
                            prefixIcon: Icons.lock,
                           obscureText: _obscureConfirmPassword.value, // Use the value of RxBool
                            onToggleObscureText: () => _obscureConfirmPassword.value = !_obscureConfirmPassword.value,
                            validator: (value) => ValidationUtil.validateConfirmPassword(value, confirmPasswordController.text),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                              onPressed: registerUser,
                              child: const Text(AppTexts.registerButton)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: DiagonalPathClipperTwo(),
                child: Container(height: 60, color: AppColors.userSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text(AppTexts.accountCreated),
        content: const Text(AppTexts.accountCreatedContent),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.to(() => const UserLoginScreen(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 500));
            },
            child: const Text(AppTexts.continueButton),
          ),
        ],
      ),
    );
  }
}