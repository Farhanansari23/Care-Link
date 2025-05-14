import 'package:flutter/material.dart';
import '../../widgets/text/custom_text.dart';



class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        }
        // Navigator.of(context).pushNamed(MarketingManagerConstants.indexPage);
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: CustomText(
            text: 'Error Page',
            size: 32,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        body: Center(
          child: CustomText(
            text: '404 Page Not Found',
            size: 24,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
