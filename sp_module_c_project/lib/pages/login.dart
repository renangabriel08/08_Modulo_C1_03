import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_module_c_project/controllers/app.dart';
import 'package:sp_module_c_project/styles/styles.dart';
import 'package:sp_module_c_project/widgets/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color cor = Cores.preto;

  List inputs = [
    {'controller': TextEditingController(), 'focus': FocusNode()},
    {'controller': TextEditingController(), 'focus': FocusNode()},
    {'controller': TextEditingController(), 'focus': FocusNode()},
    {'controller': TextEditingController(), 'focus': FocusNode()},
  ];

  logar() async {
    if (formKey.currentState!.validate()) {
      String pin = '';
      for (var input in inputs) {
        pin += input['controller'].text;
      }

      if (pin == '3245') {
        MyToast.get(App.palavras[24]);
        App.page.value = 0;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        MyToast.get(App.palavras[25]);

        for (var input in inputs) {
          input['controller'].clear();
        }

        cor = Colors.red;
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
        cor = Cores.preto;
        setState(() {});
      }
    } else {
      MyToast.get(App.palavras[26]);
    }
  }

  startApp() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(inputs.first['focus']);
    });
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      backgroundColor: Cores.branco,
      body: SizedBox(
        width: width,
        height: height,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', height: 120),
                Container(height: 16),
                Text(
                  App.palavras[8],
                  style: TextStyle(
                    color: Cores.preto,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var input in inputs)
                      SizedBox(
                        width: width * .13,
                        child: TextFormField(
                          style: TextStyle(color: Cores.preto),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          controller: input['controller'],
                          focusNode: input['focus'],
                          maxLength: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '!';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          buildCounter:
                              (
                                context, {
                                required currentLength,
                                required isFocused,
                                required maxLength,
                              }) => null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: cor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cor),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Container(height: 16),
                ElevatedButton(
                  onPressed: () => logar(),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    backgroundColor: Cores.azulClaro,
                  ),
                  child: Text(
                    App.palavras[9],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
