// BlocProvider(
//                                 create: (context) => advertismentBloc,
//                                 child: BlocBuilder<AdvertismentBloc,
//                                     AdvertismentState>(
//                                   builder: (context, state) {
//                                     if (state is SuccessGettingAdsState) {
//                                       final successAds =
//                                           state.advertisementModel.data;
//                                       return Container(
//                                         height: 75,
//                                         color: Colors.white,
//                                         child: Swiper(
//                                           autoplay: true,
//                                           itemCount: successAds.length,
//                                           itemBuilder: (context, index) {
//                                             return Image.network(
//                                               successAds[index].imageUrl,
//                                               fit: BoxFit.fitWidth,
//                                             );
//                                           },
//                                         ),
//                                       );
//                                     } else {
//                                       return Container(
//                                         color: Colors.red,
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ),
