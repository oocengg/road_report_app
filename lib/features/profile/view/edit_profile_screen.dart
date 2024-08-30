import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobileapp_roadreport/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/font_weigth.dart';
import '../../../core/state/finite_state.dart';
import '../provider/profile_provider.dart';
import '../widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Profil',
          style: TextStyle(
              fontWeight: AppFontWeight.bodySemiBold,
              fontSize: AppFontSize.bodyMedium,
              color: Colors.white),
        ),
        backgroundColor: AppColors.primary500,
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () async {
            if (!keyboardIsOpened) {
              context.read<ProfileProvider>().controllerClear();
              context.read<ProfileProvider>().getData(context);

              Navigator.pop(context);
            } else {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                await Future.delayed(const Duration(milliseconds: 500));
                if (context.mounted) {
                  context.read<ProfileProvider>().controllerClear();
                  context.read<ProfileProvider>().getData(context);

                  Navigator.pop(context);
                }
              }
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<ProfileProvider>(builder: (context, provider, _) {
            return Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alamat",
                    style: TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodySemiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        provider.validateAlamat(value, context),
                    controller: provider.alamatController,
                    enable: true,
                    hint: "Masukkan alamat rumah anda",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Nomor Ponsel",
                    style: TextStyle(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bodySemiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (value) => provider.validateNoHp(value, context),
                    controller: provider.noHpController,
                    enable: true,
                    hint: "Masukkan nomor ponsel anda",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await provider.edit(context);

                      if (context.mounted) {
                        if (provider.stateEdit == MyState.loaded) {
                          if (!keyboardIsOpened) {
                            context.read<ProfileProvider>().controllerClear();
                            context.read<ProfileProvider>().getData(context);
                            context.read<HomeProvider>().getData(context);

                            Navigator.pop(context);
                          } else {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              if (context.mounted) {
                                context
                                    .read<ProfileProvider>()
                                    .controllerClear();
                                context
                                    .read<ProfileProvider>()
                                    .getData(context);
                                context.read<HomeProvider>().getData(context);

                                Navigator.pop(context);
                              }
                            }
                          }
                        } else if (provider.stateEdit == MyState.failed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    FeatherIcons.xCircle,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text('Wrong username or password. '),
                                  ),
                                ],
                              ),
                              backgroundColor: Color.fromARGB(255, 255, 83, 71),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary500,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: provider.state == MyState.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : const Text(
                              "Ubah",
                              style: TextStyle(
                                  fontSize: AppFontSize.actionMedium,
                                  fontWeight: AppFontWeight.actionSemiBold,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
