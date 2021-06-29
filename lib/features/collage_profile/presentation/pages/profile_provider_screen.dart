import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/entities/common_question.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/collage_profile/presentation/bloc/collage_profile_bloc/collage_profile_bloc.dart';
import 'package:university/features/collage_profile/presentation/pages/collapsing_tab.dart';
import 'package:university/features/collage_profile/presentation/pages/department_screen.dart';
import 'package:university/features/collage_profile/presentation/pages/gallery_page.dart';
import 'package:university/features/collage_profile/presentation/pages/generation_screen.dart';
import 'package:university/features/common_question/presentation/pages/public_common_question.dart';

import 'years_screen.dart';

class ProfileProviderScreen extends StatefulWidget {
  static const routeName = '/profile_provider';
  final int collageId;
  ProfileProviderScreen({this.collageId});
  @override
  State<StatefulWidget> createState() {
    return _ProfileProviderScreen();
  }
}

class _ProfileProviderScreen extends State<ProfileProviderScreen>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  CollageProfileBloc collageProfileBloc;
  @override
  void initState() {
    super.initState();
    collageProfileBloc = CollageProfileBloc();
    collageProfileBloc.add(FetchCollageProfile(collageId: widget.collageId));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    super.build(context);
    return Scaffold(
        body: BlocProvider<CollageProfileBloc>(
      create: (context) => collageProfileBloc,
      child: BlocBuilder<CollageProfileBloc, CollageProfileState>(
        builder: (context, state) {
          if (state is GettingCollageProfileLoadingState)
            return LoadingView();
          else if (state is GettingCollageProfileFailed) {
            showMessage("Error happened try again");
            return BlocErrorScreen(
              function: () {
                collageProfileBloc.add(FetchCollageProfile(collageId: widget.collageId));
              },
              title: "try again",
            );
          } else if (state is GettingCollageProfileSuccess)
            return Scaffold(
                body: CollapsingTabProvider(
              scrollController: scrollController,
              collageProfileModel: state.collageProfileModel,
              tabs: [
                Tab(text: "departments"),
                Tab(text: "generations"),
                Tab(text: "years"),
                Tab(text: "common questions"),
                Tab(text: "galleries"),
              ],
              tabsBody: [
                DepartmentScreen(
                    listOfDepartmentItem:
                        state?.collageProfileModel?.data?.college?.departments ?? []),
                GenerationScreen(
                    generationList: state?.collageProfileModel?.data?.college?.generations ?? []),
                YearsScreen(yearList: state?.collageProfileModel?.data?.college?.years ?? []),
                PublicCommonQuestion(
                    collageId: state?.collageProfileModel?.data?.college?.id ?? 0,
                    needToShowBackToOriginState: false),
                GalleryPage(galleries: state?.collageProfileModel?.data?.college?.galleries ?? [])
              ],
            ));
          else {
            return Container();
          }
        },
      ),
    ));
  }
}
