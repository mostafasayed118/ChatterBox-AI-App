import 'package:chat_ai_app/core/utils/app_assets.dart';
import 'package:chat_ai_app/core/utils/app_colors.dart';
import 'package:chat_ai_app/core/utils/app_strings.dart';
import 'package:chat_ai_app/features/chat_gemini/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoad = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> callGeminiModel() async {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: _messageController.text, isUser: true));
      _isLoad = true;
    });

    // AI service is not configured. A backend proxy is required.
    // See README.md for setup instructions.
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      _messages.add(Message(
        text: 'AI chat is temporarily unavailable. The backend service that '
            'processes AI requests has not been configured yet. '
            'Please see the project README for setup instructions.',
        isUser: false,
      ));
      _isLoad = false;
    });

    _messageController.clear();
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
          //! icon button dark mode and light mode
          Semantics(
            label: 'Toggle dark mode',
            child: IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Semantics(
                  label: message.isUser ? 'You said' : 'AI said',
                  child: ListTile(
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
                    color: AppColors.greyLightColor.withValues(alpha: 0.2),
                    blurRadius: 7,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Semantics(
                  label: 'Message input',
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                      suffixIcon: Semantics(
                        label: 'Send message',
                        child: IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              callGeminiModel();
                            }
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
                                            _messages.clear();
                                          });
                                        },
                                        icon: Icon(
                                            Icons.cleaning_services_rounded,
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
            ),
          ),
        ],
      ),
    );
  }
}
