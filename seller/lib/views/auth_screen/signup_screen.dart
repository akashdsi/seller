import 'package:get/get.dart';
import 'package:goan_market/consts/consts.dart';
import 'package:goan_market/controllers/auth_controller.dart';
import 'package:goan_market/views/home_screen/home.dart';
import 'package:goan_market/widgets_common/applogo_widget.dart';
import 'package:goan_market/widgets_common/bg_widget.dart';
import 'package:goan_market/widgets_common/custom_textfield.dart';
import 'package:goan_market/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Sign up to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,

            Obx(
                () => Column(
                children: [
                  customTextField(hint: nameHint, title: name, controller: nameController,isPass: false),
                  customTextField(hint: emailHint, title: email, controller: emailController,isPass: false),
                  customTextField(hint: passwordHint, title: password, controller: passwordController,isPass: true) ,
                  customTextField(hint: retypepassHint, title: retypepassword, controller: passwordRetypeController,isPass: true),

                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetpass.text.make())),

                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.red,
                        checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue){
                          setState((){
                            isCheck = newValue;
                          });
                          },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(text: const TextSpan(
                          children: [
                            TextSpan(text: "I agree to the ", style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                            TextSpan(text: termandcond, style: TextStyle(
                              fontFamily: bold,
                              color: Colors.red,
                            )),
                            TextSpan(text: " & ", style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                            TextSpan(text: privacyPolicy, style: TextStyle(
                              fontFamily: bold,
                              color: Colors.red,
                            ))
                          ],
                        )),
                      ),
                    ],
                  ),
                  5.heightBox,
                 controller.isLoading.value? const CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(blueColor),): ourButton(color: isCheck == true? lightblue : lightGrey, title: signup, textColor: whiteColor, onPress: () async{
                   if(isCheck != false){
                     controller.isLoading(true);
                   try {
                     await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){return controller.storeUserData(
                       email: emailController.text,
                       password: passwordController.text,
                       name: nameController.text
                     );}).then((value){
                       VxToast.show(context, msg: loggedin);
                       Get.offAll(()=> const Home());
                     });
                   } catch (e){
                     auth.signOut();
                     VxToast.show(context, msg: e.toString());
                     controller.isLoading(false);
                   }
                   }
                  },).box.width(context.screenWidth-50).make(),

                  10.heightBox,
                  //wrapping in gesture detector of velocity X
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyhaveacc.text.fontFamily(bold).color(fontGrey).make(),
                      login.text.fontFamily(bold).color(Colors.red).make().onTap(() {
                        Get.back();
                      }),
                    ],
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