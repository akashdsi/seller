import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/consts/lists.dart';
import 'package:goan_market/controllers/auth_controller.dart';
import 'package:goan_market/views/auth_screen/signup_screen.dart';
import 'package:goan_market/views/home_screen/home.dart';
import 'package:goan_market/widgets_common/applogo_widget.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';
import 'package:goan_market/widgets_common/custom_textfield.dart';
import 'package:goan_market/widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget{

  const LoginScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context){

    var controller = Get.put(AuthController());


    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,

            Obx(
                () => Column(
                children: [
                  customTextField(hint: emailHint, title: email,isPass: false, controller: controller.emailController),
                  customTextField(hint: passwordHint, title: password, isPass: true, controller: controller.passwordController),

                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetpass.text.make())),
                  5.heightBox,
                  controller.isLoading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(blueColor),
                  )
                      : ourButton(color: lightblue, title: login, textColor: whiteColor, onPress: ()async{
                        controller.isLoading(true);
                    await controller.loginMethod(context: context).then((value){
                      if(value != null){
                        VxToast.show(context, msg: loggedin);
                        Get.offAll(() => const Home());

                      }else {
                        controller.isLoading(false);
                      }


                    });
                  }).box.width(context.screenWidth-50).make(),

                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(color: lightGolden, title: signup, textColor: blueColor, onPress: (){
                    Get.to(()=>const SignupScreen());
                  }).box.width(context.screenWidth-50).make(),

                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        //social buttons
                        child: Image.asset(socialIconList[index],
                        width: 30,),
                      ),
                    )),
                  ),
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            )
          ],
        ),
      ),
    ));
  }
}