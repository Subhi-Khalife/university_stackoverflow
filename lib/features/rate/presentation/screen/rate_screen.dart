import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/features/rate/presentation/bloc/bloc/rate_bloc.dart';
import 'package:university/features/rate/presentation/widgets/star_rate.dart';

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  RateBloc rateBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rateBloc = RateBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rateBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => rateBloc,
      child: BlocBuilder<RateBloc, RateState>(
        builder: (context, state) {
          if (state is FailedSendingPostRateState) {
            return Container(
              color: Colors.red,
            );
          } else if (state is LoadingRateState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ),
            );
          } else if (state is SuccessSendingPostRateState) {
            final successRate = state.rateModel;
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    successRate.data,
                  ),
                ],
              ),
            );
          } else {
            return StarFeedback();
          }
        },
      ),
    );
  }
}
