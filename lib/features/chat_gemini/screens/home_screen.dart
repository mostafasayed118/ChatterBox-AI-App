// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:chat_ai_app/core/utils/app_assets.dart';
import 'package:chat_ai_app/core/utils/app_colors.dart';
import 'package:chat_ai_app/core/utils/app_strings.dart';
import 'package:chat_ai_app/features/chat_gemini/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/theme/theme_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _message = [];
  bool _isLoad = false;
  final _formKey = GlobalKey<FormState>();

  callGeminiModel() async {
    try {
      if (_messageController.text.isNotEmpty) {
        _message.add(Message(text: _messageController.text, isUser: true));
        _isLoad = true;
        setState(() {});
      }
      final model = GenerativeModel(
          model: 'gemini-1.5-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _messageController.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _message.add(Message(text: response.text!, isUser: false));
        _isLoad = false;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    final currentTheme = ref.read(themeProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.icon,
              height: 40,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! title

                Text(
                  AppStrings.homeScreenTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                ),

                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.greenColor,
                    ),
                    SizedBox(width: 5),
                    //! online
                    Text(
                      AppStrings.online,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.greenColor,
                          ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        actions: [
          //! icon button voice chat
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.voice_chat),
          ),
          //! icon button dark mode and light mode
          IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _message.length,
              itemBuilder: (context, index) {
                final message = _message[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: message.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          // width: MediaQuery.of(context).size.width * 0.7,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? AppColors.primaryColor
                                : AppColors.whiteLightColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft:
                                  Radius.circular(message.isUser ? 20 : 0),
                              bottomRight:
                                  Radius.circular(message.isUser ? 0 : 20),
                            ),
                          ),
                          child: Text(
                            // overflow: TextOverflow.ellipsis,
                            message.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 13,
                                    fontWeight: message.isUser
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: message.isUser
                                        ? AppColors.whiteColor
                                        : AppColors.greyColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        !message.isUser
                            ? const CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage(AppAssets.chatGemini),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //! user input textField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.whiteLightColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyLightColor.withOpacity(0.2),
                    blurRadius: 7,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.searchError;
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 14,
                      ),
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        Theme.of(context).inputDecorationTheme.contentPadding,
                    hintText: AppStrings.searchHint,
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        callGeminiModel();
                        _messageController.clear();
                      },
                      icon: _isLoad
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryColor),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _message.clear();
                                      });
                                    },
                                    icon: Icon(Icons.cleaning_services_rounded,
                                        color: AppColors.redColor)),
                                const Icon(Icons.send,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
