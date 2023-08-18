import 'package:clean_architecture_number/feature/survey/presentation/widgets/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'common/widgets/advanced_line.dart';
import 'core/usecases/line.dart';
import 'injection_container.dart' as di;
import 'feature/survey/presentation/bloc/bloc.dart';
import 'injection_container.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          print("onProgress");
        },
        onPageStarted: (String url) {
          print("onPageStarted");
        },
        onPageFinished: (String url) {
          print("onPageStarted");
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (_) => sl<SurveyBloc>()..add(GetSurveyData()),
        child: BlocBuilder<SurveyBloc, SurveyState>(
          builder: (context, state) {
            if (state is Empty) {
              return Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("/images/person_place.png"),
                      ),
                    ),
                  ),
                  MessageDisplay(
                    message: 'Start searching!',
                  ),
                ],
              );
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              return Container(
                height: MediaQuery.of(context).size.height * .17,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                       height:MediaQuery.of(context).size.height * .12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(
                            height: 4,
                          ),
                          Expanded(
                            child: Container(
                              width: 10,
                              alignment: Alignment.center,
                              child: AdvancedLine(
                                direction: Axis.vertical,
                                line: DottedLine(gapSize: 2.0),
                                paintDef: Paint()
                                  ..strokeWidth = 2.0
                                  ..strokeCap = StrokeCap.round,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Icon(Icons.access_time_sharp),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue: "Azadliq Pr123",
                            decoration: InputDecoration(
                              /*prefixIcon: Column(
                                children: [
                                  Icon(Icons.ac_unit),
                                  Container(
                                    width: 10,
                                    height: 25,
                                    alignment: Alignment.center,
                                    child: AdvancedLine(
                                      direction: Axis.vertical,
                                      line: DottedLine(gapSize: 2.0),
                                      paintDef: Paint()
                                        ..strokeWidth = 2.0
                                        ..strokeCap = StrokeCap.round,
                                    ),
                                  ),
                                ],
                              ),*/
                              filled: false,
                              // contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: .5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: .5),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            indent: 30,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,

                            decoration: InputDecoration(
                              /*prefixIcon: Column(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 18,
                                    alignment: Alignment.center,
                                    child: AdvancedLine(
                                      direction: Axis.vertical,
                                      line: DottedLine(gapSize: 2.0),
                                      paintDef: Paint()
                                        ..strokeWidth = 2.0
                                        ..strokeCap = StrokeCap.round,
                                    ),
                                  ),
                                  Icon(Icons.ac_unit),
                                ],
                              ),*/

                              filled: false,
                              // contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: .5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black12, width: .5),
                              ),
                            ),
                          ),
                          /*Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.name,
                          )),*/
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            }
            return MessageDisplay(
              message: 'Unbelievable!',
            );
          },
        ),
      ),
/*      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
