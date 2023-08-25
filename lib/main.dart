import 'package:clean_architecture_number/common/widgets/app_timer.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  AppTimer appTimer = AppTimer();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    appTimer.startTimer();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    debugPrint("didChangeAppLifecycleState");

    if (state == AppLifecycleState.detached) {
      debugPrint("app is killed");
      appTimer.stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      debugPrint("app is resumed");
    } else if (state == AppLifecycleState.inactive) {
      debugPrint("inactive");
    } else if (state == AppLifecycleState.paused) {
      debugPrint("App paused");
    } else {
      debugPrint("I am undefeatable");
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("/images/person_place.png"),
                      ),
                    ),
                  ),
                  const MessageDisplay(
                    message: 'Start searching!',
                  ),
                ],
              );
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Loaded) {

              /*return Container(
                height: MediaQuery.of(context).size.height * .17,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.ac_unit),
                          const SizedBox(
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
                          const SizedBox(
                            height: 4,
                          ),
                          const Icon(Icons.access_time_sharp),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue: "Azadliq Pr123",
                            decoration: const InputDecoration(
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
                          const Divider(
                            height: 1,
                            indent: 30,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              filled: false,
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
                          *//*Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.name,
                          )),*//*
                        ],
                      ),
                    )
                  ],
                ),
              );*/
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            }
            return const MessageDisplay(
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
      child: const Center(
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
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
