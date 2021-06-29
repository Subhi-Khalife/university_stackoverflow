import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/advertisement/data/models/advertisment.dart';
import '../../../../core/widget/colors.dart';
import '../bloc/bloc/advertisment_bloc.dart';

class AdvertismentScreen extends StatefulWidget {
  @override
  _AdvertismentScreenState createState() => _AdvertismentScreenState();
}

class _AdvertismentScreenState extends State<AdvertismentScreen> {
  AdvertismentBloc advertismentBloc;

  @override
  void initState() {
    super.initState();
    advertismentBloc = AdvertismentBloc()
      ..add(
        FetchAdvertismentEvent(),
      );
  }

  @override
  void dispose() {
    super.dispose();
    advertismentBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (context) => advertismentBloc,
        child: BlocBuilder<AdvertismentBloc, AdvertismentState>(
          builder: (context, state) {
            if (state is FailedGettingAdsState) {
              return BlocErrorScreen(
                function: () {
                  advertismentBloc.add(FetchAdvertismentEvent());
                },
                title: "Error Happened try again",
              );
            } else if (state is LoadingAdsState) {
              return LoadingView();
            } else if (state is SuccessGettingAdsState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right:16),
                  child: Container(
                      height: 350,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          showSwipper(state.advertisementModel),
                          closIcon(),
                        ],
                      )),
                ),
              );
            } else {
              return Container(
                color: Colors.orangeAccent,
              );
            }
          },
        ),
      ),
    );
  }

  Widget showSwipper(AdvertisementModel model) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: new Image.network(
            model.data[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
      itemCount: model.data.length,
      autoplay: true,
      viewportFraction:1,
      scale: 1,
    );
  }

  Widget closIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(120),
        child: Container(
            color: Colors.black26,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white))),
      ),
    );
  }
}
