import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/challenge/presentation/screen/view_model.dart';
import 'package:starter_application/main.dart';

class MapLocationScreen extends StatefulWidget {
  static const routeName = "/MapLocationScreen";

  MapLocationScreen({
    required this.initialPosition,
    super.key,
  });

  final LatLng initialPosition;

  @override
  _MapLocationScreenState createState() => _MapLocationScreenState();
}

class _MapLocationScreenState extends State<MapLocationScreen> {
  final MapViewModel _viewModel = MapViewModel();
  GoogleMapController? _controller;

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  // void _setMarker(LatLng latLng) {
  //   _viewModel.setSourceMarker(latLng);
  // }

  @override
  Widget build(BuildContext context) {
    print('build');

    return ProgressHUD(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildCustomAppbar(
            title: buildAppbarTitle(isArabic ? 'الموقع' : 'location',
                size: TitleSize.medium)),
        body: _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              StreamBuilder<Position>(
                stream: _viewModel.outCurrentPosition,
                builder: (context, snapshot) {
                  final currentPosition = snapshot.data;
                  if (currentPosition != null) {
                    _viewModel.setSourceMarker(LatLng(
                      currentPosition.latitude,
                      currentPosition.longitude,
                    ));
                  }
                  return StreamBuilder2(
                    streams: StreamTuple2<List<Marker>, List<Polyline>>(
                      _viewModel.outMarkers,
                      _viewModel.outPolyLines,
                    ),
                    builder: (context, snapshots) {
                      final markers = snapshots.snapshot1.data?.toSet() ?? {};
                      return currentPosition == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ))
                          : GoogleMap(
                              markers: markers,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  currentPosition.latitude,
                                  currentPosition.longitude,
                                ),
                                zoom: 16,
                              ),
                        onMapCreated: (controller) {
                                _controller = controller;
                              },
                              onTap: (latLng) {
                                _viewModel.setSourceMarker(latLng);
                                _controller?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        latLng.latitude,
                                        latLng.longitude,
                                      ),
                                      zoom: 16,
                                    ),
                                  ),
                                );
                              },
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                            );
                    },
                  );
                },
              ),
              // Positioned(
              //   bottom: AppSize.s100.h,
              //   right: 16.0,
              //   child: Column(
              //     children: [
              //       FloatingActionButton(
              //         heroTag: "location",
              //         onPressed: () {
              //           _viewModel.getPosition();
              //         },
              //         backgroundColor: ColorManager.white,
              //         child:
              //         Icon(Icons.my_location, color: ColorManager.primary),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                isArabic ? 'تم' : 'Done',
                style: const TextStyle(color: Colors.black, fontSize: 30),
              ),
              onPressed: () {
                Navigator.pop(context, [
                  _viewModel.mapModel.sourceLatLng
                ]);
              },
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(AppPadding.p16.w),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         children: [
        //           Icon(Icons.location_on_outlined, color: ColorManager.primary),
        //           StreamBuilder<String>(
        //               stream: _viewModel.outLocationAddress,
        //               builder: (context, snapshot) {
        //                 return snapshot.data == null
        //                     ? CircularProgressIndicator(
        //                         color: ColorManager.primary,
        //                       )
        //                     : Text(
        //                         snapshot.data!,
        //                         style: TextStyle(color: ColorManager.primary),
        //                       );
        //               }),
        //         ],
        //       ),
        //       SizedBox(height: 10.h),
        //       const SizedBox(height: 20),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shaial/presentation/common/reusable/custom_button.dart';
// import 'package:shaial/presentation/common/state_render/state_renderer_imp.dart';
// import 'package:shaial/presentation/map_screen/view_model.dart';
// import 'package:shaial/presentation/resources/color_manager.dart';
// import 'package:shaial/presentation/resources/string_manager.dart';
// import 'package:shaial/presentation/resources/values_manager.dart';
//
// class MapLocationScreen extends StatefulWidget {
//   const MapLocationScreen({super.key, required this.title});
//
//   final String title;
//
//   @override
//   _MapLocationScreenState createState() => _MapLocationScreenState();
// }
//
// class _MapLocationScreenState extends State<MapLocationScreen> {
//   bool _saveLocation = false;
//
//   final MapViewModel _viewModel = MapViewModel();
//   final LatLng _initialPosition = const LatLng(37.7749, -122.4194);
//
//   GoogleMapController? _controller;
//   Position? _currentPosition;
//   String _currentAddress = '';
//
//   @override
//   void initState() {
//     _viewModel.start();
//     // _viewModel.getPosition();
//     super.initState();
//   }
//   List<Marker> markers = [];
//   setMarker(LatLng latLng) {
//       // markers.clear();
//       markers.add(Marker(
//         markerId: const MarkerId('marker'),
//         position: latLng,
//       ));
//   }
//
//   final String _location = AppStrings.location;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.white,
//       appBar: AppBar(
//         title: Text(widget.title),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: StreamBuilder<StateFlow>(
//         stream: _viewModel.outputState,
//         builder: (context, snapshot) =>
//             snapshot.data?.getScreenWidget(
//               context,
//               _getContent(),
//               () {
//                 // _loginViewModel.login();
//               },
//             ) ??
//             _getContent(),
//       ),
//     );
//   }
//
//   _getContent() {
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               StreamBuilder(
//                   stream: _viewModel.outCurrentPosition,
//                   builder: (context, snapshot) {
//                     _currentPosition = snapshot.data;
//                     if(snapshot.data != null){
//                       setMarker(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
//                     }
//                     return _currentPosition == null
//                         ? const Center(child: CircularProgressIndicator())
//                         : GoogleMap(
//                             markers: markers.toSet(),
//                             initialCameraPosition: CameraPosition(
//                               target: LatLng(
//                                 _currentPosition!.latitude,
//                                 _currentPosition!.longitude,
//                               ),
//                               zoom: 16,
//                             ),
//                             onMapCreated: (GoogleMapController controller) {
//                               _controller = controller;
//                             },
//                             onTap: (LatLng latLng) {
//                               _saveLocation = true;
//                               // _viewModel.saveLocation(latLng);
//                               setMarker(latLng);
//                               _controller!.animateCamera(
//                                 CameraUpdate.newCameraPosition(
//                                   CameraPosition(
//                                     target: LatLng(
//                                       latLng.latitude,
//                                       latLng.longitude,
//                                     ),
//                                     zoom: 16,
//                                   ),
//                                 ),
//                               );
//                               setState(() {
//                               });
//                             },
//                             myLocationEnabled: true,
//                             myLocationButtonEnabled: true,
//                           );
//                   }),
//               Positioned(
//                 bottom: AppSize.s100.h,
//                 right: 16.0,
//                 child: Column(
//                   children: [
//                     // FloatingActionButton(
//                     //   heroTag: "question",
//                     //   onPressed: () {
//                     //     // Handle help action
//                     //   },
//                     //   backgroundColor: ColorManager.white,
//                     //   child: Icon(Icons.help_outline, color: ColorManager.primary),
//                     // ),
//                     // const SizedBox(height: 8.0),
//                     FloatingActionButton(
//                       heroTag: "location",
//                       onPressed: () {
//                         _viewModel.getPosition();
//                       },
//                       backgroundColor: ColorManager.white,
//                       child:
//                           Icon(Icons.my_location, color: ColorManager.primary),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(AppPadding.p16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.location_on_outlined, color: ColorManager.primary),
//                   Text(
//                     _location,
//                     style: TextStyle(color: ColorManager.primary),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               GestureDetector(
//                 onTap: () async {
//                   showPicker(context);
//                 },
//                 child: StreamBuilder<File>(
//                     stream: _viewModel.outLocationImage,
//                     builder: (context, snapshot) {
//                       return Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(AppPadding.p10.w),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: ColorManager.primary),
//                           borderRadius: BorderRadius.circular(AppSize.s8.r),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   AppStrings.addLocationImage,
//                                   style: TextStyle(color: ColorManager.primary),
//                                 ),
//                                 Icon(Icons.file_upload_outlined,
//                                     color: ColorManager.primary),
//                               ],
//                             ),
//                             snapshot.data != null
//                                 ? imagePicketByUser(snapshot.data)
//                                 : const SizedBox(),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _saveLocation,
//                     checkColor: ColorManager.white,
//                     activeColor: ColorManager.primary,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         _saveLocation = value!;
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 8.0),
//                   Text(AppStrings.saveLocationForLater,
//                       style: TextStyle(color: ColorManager.fontPrimary)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               customElevatedButton(
//                 stream: _viewModel.outIsFormValid,
//                 text: AppStrings.done,
//                 onPressed: () {
//                   Navigator.pop(context, [_location]);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   showPicker(
//     BuildContext context,
//   ) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 trailing: const Icon(Icons.arrow_forward),
//                 leading: const Icon(Icons.camera),
//                 title: Text(AppStrings.photoGallery.tr()),
//                 onTap: () {
//                   _imageFromGallery();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 trailing: const Icon(Icons.arrow_forward),
//                 leading: const Icon(Icons.camera_alt_outlined),
//                 title: Text(AppStrings.photoCamera.tr()),
//                 onTap: () {
//                   _imageFromCamera();
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   _imageFromGallery() async {
//     var image = await _imagePicker.pickImage(source: ImageSource.gallery);
//     _viewModel.setImage(File(image?.path ?? ""));
//   }
//
//   _imageFromCamera() async {
//     var image = await _imagePicker.pickImage(source: ImageSource.camera);
//     _viewModel.setImage(File(image?.path ?? ""));
//   }
//
//   Widget imagePicketByUser(File? image) {
//     if (image != null && image.path.isNotEmpty) {
//       print('imagePiker ${image.path}');
//       return Image.file(
//         image,
//         height: 100.h,
//       );
//     } else {
//       return const SizedBox();
//     }
//   }
// }
