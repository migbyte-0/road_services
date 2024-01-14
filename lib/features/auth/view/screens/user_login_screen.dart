import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants_exports.dart';
import '../../../../core/shared/shared_exports.dart';
import '../../../workshop_user/view/validators/validation_util.dart';
import 'user_registration_screen.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();


    final RxBool _obscurePassword = true.obs;


    return Scaffold( backgroundColor:AppColors.userPrimaryColor ,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const LoginBackground(
              firstColor: AppColors.userSecondaryColor, 
              secondColor:  AppColors.userThirdColor, 
              thirdColor:  AppColors.userFourthColor, 
              firstHeight: 400, 
              secondHeight: 300,
               thirdHeight: 200),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [                   
                   const SizedBox(height: 60),
                         const LoginLogo(
                      logo: 'lib/assets/images/user.png', 
                      firstColor:  AppColors.userPrimaryColor,  
                       secondColor:   AppColors.userFourthColor, ),    
 
  
                                     const SizedBox(height: 40),
              CustomTextField(
                      controller: emailController,
                      hintText: AppTexts.email,
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
      obscureText: _obscurePassword.value,
  onClear: () => emailController.clear(),
                      validator: (value) => ValidationUtil.validateEmail(value),
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
                    onPressed: () {
                      // controller.loginUser(
                      //     emailController.text, passwordController.text);
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
                          Get.to(() => const UserRegistrationScreen());
                        },
                        child:  Text(AppTexts.createAnAccount, style: Styles.style20White),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
