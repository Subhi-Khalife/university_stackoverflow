import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // TODO: implement initState
    super.initState();
    advertismentBloc = AdvertismentBloc()
      ..add(
        FetchAdvertismentEvent(),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    advertismentBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => advertismentBloc,
        child: BlocBuilder<AdvertismentBloc, AdvertismentState>(
          builder: (context, state) {
            if (state is FailedGettingAdsState) {
              print("Done");
              return Container(
                color: Colors.red,
              );
            } else if (state is LoadingAdsState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorThemApp,
                ),
              );
            } else if (state is SuccessGettingAdsState) {
              final ads = state.advertisementModel.data[1];
              return Center(
                child: Container(
                  child: Text(
                    ads.link,
                  ),
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
}
