import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/core/widgets/custom_image.dart';

import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/commons.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../data/models/on_boarding_model.dart';

class OnBoaringScreens extends StatefulWidget {
  const OnBoaringScreens({super.key});

  @override
  State<OnBoaringScreens> createState() => _OnBoaringScreensState();
}

class _OnBoaringScreensState extends State<OnBoaringScreens> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(24),
        child: PageView.builder(
          controller: controller,
          itemCount: OnBoardingModel.onBoardingScreens.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                //skip text
                index != 2
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextButton(
                          text: AppStrings.skip,
                          onPressed: () {
                            controller.jumpToPage(2);
                          },
                        ),
                      )
                    : SizedBox(height: 50.h),
                SizedBox(height: 16.h),
                //image

                CustomImage(
                  imgPath: OnBoardingModel.onBoardingScreens[index].imagePath,
                  h: 300.h,
                  w: 300.w,
                ),
                SizedBox(
                  height: 48.h,
                ),

                //title
                Text(
                  OnBoardingModel.onBoardingScreens[index].title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 8.h,
                ),

                //subTitle
                Text(
                  OnBoardingModel.onBoardingScreens[index].subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 70.h,
                ),

                //dots
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      // dotColor: AppColors.red
                      dotHeight: 10,
                      spacing: 8
                      // dotWidth: 10
                      ),
                ),
                const Spacer(),
                //buttons
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back button
                    index != 0 && index != 2
                        ? CustomTextButton(
                            text: AppStrings.back,
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            },
                          )
                        : Container(),
                    //spacer
                    const Spacer(),
                    //next Button
                    if (index != 2)
                      CustomButton(
                        text: AppStrings.next,
                        width: 125,
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                      ),
                    if (index == 2)
                      CustomButton(
                          width: 375,
                          text: AppStrings.getStarted,
                          onPressed: () async {
                            // navigate to home screen
                            await sl<CacheHelper>()
                                .saveData(
                                    key: AppStrings.onBoardingKey, value: true)
                                .then((value) {
                              // print('onBoarding is Visited');
                              navigate(context: context, route: Routes.login);
                            }).catchError((e) {
                              // print(e.toString());
                            });
                          })
                  ],
                ),
              ],
            );
          },
        ),
      )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
