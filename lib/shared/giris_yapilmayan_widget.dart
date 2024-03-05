import 'package:LAST_SUMMER_COFFE/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget girisYapilmayanWidget(LoginController loginController) {
  final _formKey = GlobalKey<FormState>();

  return Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            child: FaIcon(
              FontAwesomeIcons.exclamation,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Henüz Giriş Yapmadınız.\nYönetim Panelini Görmek için Lütfen Giriş Yapınız.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kullanıcı Adı',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: TextFormField(
              controller: loginController.personelNameController,
              validator: (String? value) {
                if (value!.length <= 3) {
                  return 'Geçerli bir kullanıcı adı giriniz!';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Kullanıcı adınızı giriniz..',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Şifre',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: TextFormField(
              obscureText: true,
              controller: loginController.passwordController,
              validator: (String? value) {
                if (value!.length < 3) {
                  return 'Geçerli bir şifre giriniz!';
                }
                return null;
              },
              onFieldSubmitted: (value) async {
                if (_formKey.currentState!.validate()) {
                  if ((loginController.personelNameController.text.toLowerCase() == 'emre' ||
                          loginController.personelNameController.text.toLowerCase() == 'mustafa' ||
                          loginController.personelNameController.text.toLowerCase() == 'hakan' ||
                          loginController.personelNameController.text.toLowerCase() == 'emrullah') &&
                      (loginController.passwordController.text.toLowerCase() == 'mstf.0101' ||
                          loginController.passwordController.text.toLowerCase() == 'emr.0101' ||
                          loginController.passwordController.text.toLowerCase() == 'hkn.0101' ||
                          loginController.passwordController.text.toLowerCase() == 'emir.0101')) {
                    await loginController.loginFun();
                  } else {
                    loginController.errorLoginFun();
                  }
                }
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Şifrenizi giriniz..',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              if (loginController.errorLogin == true)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Kullanıcı Bulunamadı !',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if ((loginController.personelNameController.text.toLowerCase() == 'emre' ||
                            loginController.personelNameController.text.toLowerCase() == 'mustafa' ||
                            loginController.personelNameController.text.toLowerCase() == 'hakan' ||
                            loginController.personelNameController.text.toLowerCase() == 'emrullah') &&
                        (loginController.passwordController.text.toLowerCase() == 'mstf.0101' ||
                            loginController.passwordController.text.toLowerCase() == 'emr.0101' ||
                            loginController.passwordController.text.toLowerCase() == 'hkn.0101' ||
                            loginController.passwordController.text.toLowerCase() == 'emir.0101')) {
                      await loginController.loginFun();
                    } else {
                      loginController.errorLoginFun();
                    }
                  }
                },
                child: Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Checkbox(
              //       value: loginController.rememberMe,
              //       onChanged: (value) {
              //         loginController.rememberMeFun();
              //       },
              //     ),
              //     const Text(
              //       'Beni Hatırla',
              //       textAlign: TextAlign.center,
              //     )
              //   ],
              // ),
            ],
          )
        ],
      ),
    ),
  );
}
