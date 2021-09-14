import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/feedback/presentation/widgets/feedback_comment.dart';

import '../../../../core/widget/colors.dart';
import '../bloc/bloc/feedback_bloc.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackBloc feedbackBloc;

  @override
  void initState() {
    super.initState();

    feedbackBloc = FeedbackBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    feedbackBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => feedbackBloc,
      child: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (context, state) {
            return HomePage();
        },
      ),
    );
  }
}
