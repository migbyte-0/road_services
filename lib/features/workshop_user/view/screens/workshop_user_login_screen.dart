import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants_exports.dart';
import '../../../../core/shared/shared_exports.dart';
import '../controller/workshop_user_controller.dart';
import '../validators/validation_util.dart';
import 'additional_details_screen.dart';
import 'workshop_user_registration_screen.dart';

class WorkShopUserLoginScreen extends StatelessWidget {
  const WorkShopUserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkShopUserController controller = Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();




    final RxBool _obscurePassword = true.obs;


    return   Scaffold(
      backgroundColor: AppColors.roadServicesPrimaryColor,
      body: Stack(
        children: [
          const LoginBackground( 
            firstColor:AppColors.workShopSecondaryColor,
             secondColor: AppColors.workShopThirdColor, 
             thirdColor: AppColors.workShopFourthColor,
              firstHeight: 400,
               secondHeight: 800,
                thirdHeight: 100,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey, // Assign the GlobalKey to the Form
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const LoginLogo(
                      logo: 'lib/assets/images/workshop_user.png', 
                      firstColor: AppColors.workShopPrimaryColor, 
                       secondColor:  AppColors.workShopThirdColor,),     
                                   const SizedBox(height: 40),
                      
                CustomTextField(  
                        controller: emailController,
                        hintText: AppTexts.email,
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => ValidationUtil.validateEmail(value),
                        onClear: () => emailController.clear(),
                      ),
                      
                                                
                    const SizedBox(height: 20),
                         Obx(() => CustomTextField(
                            controller: passwordController,
                            hintText: AppTexts.password,
                            prefixIcon: Icons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscurePassword.value, // Use the value of RxBool
                            validator: (value) => ValidationUtil.validatePassword(value),
                            onToggleObscureText: () => _obscurePassword.value = !_obscurePassword.value,
                          )),
                      
                    const SizedBox(height: 50),
               ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, show loading dialog
      Get.dialog(
        const AppLoading(),
        barrierDismissible: false, // Prevent dismissing by tapping outside
      );

      // Attempt to login the user
      User? user = await controller.loginWorkShopUser(
        emailController.text, passwordController.text
      );

      // Dismiss the loading dialog
      Get.back();

      if (user != null) {
        // User exists and is logged in, navigate to the Additional Details Screen
        Get.to(() => const WorkShopUserAdditionalDetailsScreen());
      } else {
        // User doesn't exist or login failed, show error message
        Get.snackbar(AppTexts.error, AppTexts.noAccountExist, 
          backgroundColor: Colors.white, colorText: Colors.red
        );
      }
    } else {
      // Form is not valid, show error message
      Get.snackbar(AppTexts.error, AppTexts.fieldsEmpty, 
        backgroundColor: Colors.white, colorText: Colors.red
      );
    }
  },
  child: const Text(AppTexts.enter),
),

                      
                      
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppTexts.noAccount, style: Styles.style16White),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const  WorkShopUserRegistrationScreen());
                          },
                          child: Text(AppTexts.createAnAccount, style: Styles.style20White),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
