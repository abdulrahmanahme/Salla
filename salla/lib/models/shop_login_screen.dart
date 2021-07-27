import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/Layout/home_layout.dart';
import 'package:salla/shard/components/components.dart';
import 'package:salla/shard/components/cubit/Cubit.dart';
import 'package:salla/shard/components/cubit/status.dart';
import 'package:salla/shard/sharedpr.dart';

class Shoploginscreen extends StatefulWidget {
  @override
  _ShoploginscreenState createState() => _ShoploginscreenState();
}

class _ShoploginscreenState extends State<Shoploginscreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaShopCubit, SallaShopStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessStatus) {
          if (state.loadingModel.status) {
            // CashHelper.saveData(key: key, value: value);
            print(state.loadingModel.message);
            print(state.loadingModel.data.token);
            CashHelper.saveData(
                    key: 'token', value: state.loadingModel.data.token)
                .then((value) {
              navigatAndfinsh(context, ShopLayout());
            });
            // ShowToast(

            //     text: state.loadingModel.message,
            //state: ToastState.SUCCESS);

          } else {
            print(state.loadingModel.message);

            ShowToast(
                text: state.loadingModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text_Form_Widget(
                          controller: emailcontroller,
                          hintText: 'Email Address',
                          obscureText: false,
                          prefixIcon: Icon(Icons.email_outlined),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your email';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text_Form_Widget(
                          controller: passwordcontroller,
                          hintText: 'Password ',
                          obscureText: true,
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),

                          // suffix: ShopingLoginCubit.get(context).suffix,
                          prefixIcon: Icon(Icons.lock_outline),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your password';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStatus,
                          builder: (context) => ElevatedButton(
                            child: Text("LOGIN"),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.blue,
                                onSurface: Colors.red,
                                minimumSize: Size(350, 50),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 60),
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // fontFamily: "alex",
                                )),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                SallaShopCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t hava an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
