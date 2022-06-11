import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';

class InfoPage extends StatefulWidget {
  final bool isContactUs;
  const InfoPage({Key? key, required this.isContactUs}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final String _contactUs = 'It should be mentioned that sending us comments or bug reports is entirely up to your own free '
      'will and discretion.\n\nStudentfitness@gmail.com is the email address to contact if you have questions about our '
      'privacy policies or concerns about how your personal information is being handled. We will do our best to respond '
      'to your inquiries in a timely way';
  final String _privacyPolicy = "We place a high value on your privacy. StudentReminder  operates on a few essential "
      "principles:\n\nWe never ask for personal information unless we really need it. (We despise services that request "
      "information like your gender or financial level for no apparent reason.)\nExcept to comply with the law, develop "
      "our goods, or protect our rights, we do not disclose your personal information with anybody.\nPersonal information "
      "is not stored on our systems unless it is necessary for the ongoing functioning of one of our services."
      "\nThe following is our privacy policy, which contains these objectives:\n\nWebsite Visitors\nStudentReminder "
      "like other apps operators, gathers non-personally-identifying information of the kind that web browsers and "
      "servers routinely provide, such as browser type, referring site, and the date and time of each visitor request. "
      "StudentReminder goal in collecting non-personally identifying information is to better understand how  website "
      "visitors utilise it may from time to time share aggregated non-personally-identifying information, such as by "
      "producing a report on website usage patterns.\n\nGathering of Personally-Identifying Information\nIf you are a "
      "registered user of a StudentReminder app and have provided your email address, it may send you an email from time "
      "to time to inform you about new features, elicit feedback, or just keep you up to speed on what's going on with "
      "our products. We want to keep this sort of communication to a minimum because we typically disseminate this type "
      "of information through our numerous product blogs. If you submit us a request (for example, via a support email "
      "or one of our feedback systems), we have the right to publish it to help us explain or reply to your request, "
      "or to assist other users. StudentReminder takes all reasonable precautions to protect its customers.\n\nCOOKIES"
      "\nA cookie is a string of data that a website maintains on a visitor's computer and that the visitor's browser "
      "sends to the website every time the visitor returns. our employs cookies to assist app in identifying and tracking "
      "visitors, their website usage, and their website access preferences. Todo.ly visitors who do not want cookies "
      "installed on their computers may configure their browsers to refuse cookies before visiting StudentReminder app, "
      "with the caveat that certain elements of may not work correctly without cookies.\n\nPrivacy Policy Changes"
      "\nStudentReminder advises users to review this page periodically for changes to its Privacy Policy. If you have a  "
      "account, you should also check the dashboard of your blog for notifications of these changes. Your continued use "
      "of this site following any changes to this Privacy Policy constitutes your acceptance of such changes.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(child: Column(children: [

        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(
            Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          title: Text(widget.isContactUs ? 'Contact Us' : 'Privacy Policy', style: poppinsBold.copyWith(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          centerTitle: true, elevation: 0,
        ),

        Expanded(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Text(widget.isContactUs ? _contactUs : _privacyPolicy, style: poppinsRegular.copyWith(fontSize: 12)),
        )),

      ])),
    );
  }
}
