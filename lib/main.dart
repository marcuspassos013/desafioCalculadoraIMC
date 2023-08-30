import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color greyColor = Colors.grey.shade300;
  Color textColor = Colors.grey.shade600;
  Color blueColor = Colors.blue.shade300;
  Color whiteColor = Colors.white;
  Color warningColor = Colors.grey.shade300;

  TextEditingController weightInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

  double resultado = 0;
  double peso = 0;
  double altura = 0;
  String imcResultado = '';

  bool isEmpty = true;
  bool isPressed1 = false;
  bool isPressed2 = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){

    //for button press
    double blurRad1 = isPressed1 ? 10.0 : 20.0;
    double blurRad2 = isPressed2 ? 10.0 : 20.0;
    Offset spaceDistance1 = isPressed1 ? const Offset(3, 3) : const Offset(-5, -5);
    Offset spaceDistance2= isPressed2 ? const Offset(3, 3) : const Offset(-5, -5);

    //for constant box shadow
    double blurRad3 = 10.0;
    Offset spaceDistance3 = const Offset(3, 3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor,
        appBar: AppBar(
          title: Text(
            'IMC Calculator',
            style: TextStyle(fontWeight: FontWeight.bold,color: textColor),
          ),
          centerTitle: true,
          backgroundColor: greyColor,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              //Result
              Container(
                  padding: const EdgeInsets.all(25.0),
                  width: double.maxFinite,
                  height: 150,
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: blurRad3,
                          offset: spaceDistance3,
                          color: Colors.grey,
                        ),
                        BoxShadow(
                          blurRadius: blurRad3,
                          offset: -spaceDistance3,
                          color: Colors.white,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            resultado != 0 ? resultado.toStringAsFixed(1) : '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            imcResultado,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.circle,
                        color: warningColor,
                      ),
                    ],
                  )),
              const SizedBox(height: 30,),

              //TextField for Weight Input
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: blurRad3,
                      offset: spaceDistance3,
                      color: Colors.grey,
                    ),
                    BoxShadow(
                      blurRadius: blurRad3,
                      offset: -spaceDistance3,
                      color: Colors.white,
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(color: textColor, fontSize: 24),
                  controller: weightInput,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Peso em KG',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Informe seu peso',
                    labelStyle: TextStyle(color: textColor),
                    border: InputBorder.none,
                    suffix: Text(
                      'KG',
                      style: TextStyle(fontSize: 16,color: textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),

              //TextField for Height Input
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: blurRad3,
                        offset: spaceDistance3,
                        color: Colors.grey,
                      ),
                      BoxShadow(
                        blurRadius: blurRad3,
                        offset: -spaceDistance3,
                        color: Colors.white,
                      ),
                    ]),
                child: TextField(
                  style: TextStyle(color: textColor, fontSize: 24),
                  controller: heightInput,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Altura em Metros',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Informe sua altura',
                    labelStyle: TextStyle(color: textColor),
                    border: InputBorder.none,
                    suffix: Text(
                      'Metros',
                      style: TextStyle(fontSize: 16,color: textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Reset Button
                  Listener(
                    onPointerUp: (_) {
                      weightInput.clear();
                      heightInput.clear();
                      setState(() {
                        isPressed1 = true;
                        resultado = 0;
                        imcResultado = '';
                        warningColor = Colors.grey.shade300;
                      });
                    },
                    onPointerDown: (_){
                      setState(() {
                        isPressed1 = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: blurRad1,
                              offset: spaceDistance1,
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: blurRad1,
                              offset: -spaceDistance1,
                              color: Colors.white,
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        'Reset',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),

                  //Calculate Button
                  Listener(
                    onPointerUp: (_) {
                      setState(() {
                        isPressed2 = true;
                        if (weightInput.text.isNotEmpty) {
                          peso = double.parse(weightInput.text);
                          altura = double.parse(heightInput.text);
                          resultado = (peso / (altura * altura));
                          if (resultado < 16) {
                            imcResultado = 'Magreza Grave';
                            warningColor = Colors.yellow;
                          } else if (resultado >= 16 && resultado < 17 ) {
                            imcResultado = 'Magreza Moderada';
                            warningColor = Colors.green;
                          } else if (resultado >= 17 && resultado < 18.5 ) {
                            imcResultado = 'Magreza Leve';
                            warningColor = Colors.orange;
                          }else if (resultado >= 18.5 && resultado < 25 ) {
                            imcResultado = 'Saudável';
                            warningColor = Colors.blue;
                          }else if (resultado >= 25 && resultado < 30 ) {
                            imcResultado = 'Sobrepeso';
                            warningColor = Colors.purple;
                          }else if (resultado >= 30 && resultado < 35 ) {
                            imcResultado = 'Obesidade Grau I';
                            warningColor = Colors.brown;
                          }else if (resultado >= 35 && resultado < 40 ) {
                            imcResultado = 'Obesidade Grau II';
                            warningColor = Colors.red.shade600;
                          }else if (resultado >= 40 ) {
                            imcResultado = 'Obesidade Grau III';
                            warningColor = Colors.purple.shade700;
                          } 
                        } else {
                          imcResultado = 'Informe um valor 😑';
                        }
                      });
                    },
                    onPointerDown: (_){
                      setState(() {
                        isPressed2 = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: blurRad2,
                              offset: spaceDistance2,
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: blurRad2,
                              offset: -spaceDistance2,
                              color: Colors.white,
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
