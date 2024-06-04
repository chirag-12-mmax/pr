import 'package:flutter/material.dart';
import 'package:shah_investment/constants/colors.dart';
import 'package:shah_investment/constants/navigation_screen.dart';
import 'package:shah_investment/constants/text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RefundReturnPolicy extends StatefulWidget {
  const RefundReturnPolicy({super.key});

  @override
  State<RefundReturnPolicy> createState() => _RefundReturnPolicyState();
}

class _RefundReturnPolicyState extends State<RefundReturnPolicy> {
  bool isLoading = false;
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrlData();
  }

  void getUrlData() {
    setState(() {
      isLoading = true;
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://shahsinvestment.com/refund-return-policy/'));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PickColors.whiteColor,
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              backToScreen(context: context);
            },
            child: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
          title: Text(
            "Refund Return Policy",
            style: CommonTextStyle.noteTextStyle.copyWith(
              color: PickColors.blackColor,
            ),
          ),
        ),
        body: !isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: WebViewWidget(controller: controller))
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
