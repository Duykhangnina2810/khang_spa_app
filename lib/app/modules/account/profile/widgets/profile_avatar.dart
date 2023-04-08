import 'dart:io';
import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../constants/api_url.dart';
import '../../../../constants/app_ui.dart';
import '../../../authentication/provider/auth_controller.dart';
import '../provider/profile_controller.dart';


class ProfileAvatar extends ConsumerStatefulWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends ConsumerState<ProfileAvatar> {
  late File imageFile;
  late String avatar;
  late String avatar2 = "";
  late String avatar3;
  final ImagePicker _picker = ImagePicker();
  int type = 0;

  @override
  Widget build(BuildContext context) {
    final infoUser = ref.watch(authProvider).authUserModel;
    if (infoUser != null) {
      return Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Xem ảnh đại diện'),
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) => ImageDialog(
                                        infoUser.avatar.toString()));
                              },
                            ),
                            ListTile(
                                title: new Text('Chọn ảnh từ thiết bị'),
                                onTap: () {
                                  _getFromGallery();
                                }),
                            ListTile(
                              title: new Text('Chụp ảnh'),
                              onTap: () {
                                _getFromCamera();
                              },
                            ),
                            ListTile(
                              title: new Text('Thoát'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: 40)
                          ],
                        );
                      });
                },
                child: GFAvatar(
                  backgroundImage: (infoUser.avatar!.isNotEmpty)
                      ? (infoUser.flagAvatar == true)
                          ? NetworkImage("${ApiUrl.baseUrl}/${infoUser.avatar}")
                          : NetworkImage(infoUser.avatar!)
                      : const AssetImage(AppUI.icUserDefault) as ImageProvider,
                  backgroundColor: Colors.grey,
                  size: 50,
                ),
              ),
              Positioned(
                  bottom: 7,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                    ),
                    child: Icon(
                      size: 12,
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  infoUser.fullName.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  infoUser.email,
                  style: TextStyle(
                    color: const Color(0xFF828282),
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Container();
  }

  _getFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      avatar2 = imageFile.path;
      type = 1;
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        Navigator.of(context).push(new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new SomeDialog(
                  Url: imageFile.path, imageToCrop: imageBytes);
            },
            fullscreenDialog: true));
      });
    }
  }

  _getFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 5000,
      maxHeight: 5000,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      avatar2 = imageFile.path;
      type = 1;
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        Navigator.of(context).push(new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new SomeDialog(
                  Url: imageFile.path, imageToCrop: imageBytes);
            },
            fullscreenDialog: true));
      });
    }
  }
}

class ImageDialog extends StatefulWidget {
  String ImageSrc;

  ImageDialog(this.ImageSrc);

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  late Size imageSize = const Size(0.00, 0.00);
  bool find = false;

  @override
  Widget build(BuildContext context) {
    _getImageDimension();
    double maxW = MediaQuery.of(context).size.width;
    double maxH = MediaQuery.of(context).size.height;
    double width = imageSize.width;
    double height = imageSize.height;
    double dimentsion = width / maxW;

    if (width > maxW) {
      dimentsion = (maxW - 40) / width;
      width = maxW - 40;
      height = height * dimentsion;
    }

    if (height > maxH) {
      dimentsion = (maxH - 40) / height;
      height = maxH - 40;
      width = width * dimentsion;
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.ImageSrc), fit: BoxFit.scaleDown)),
      ),
    );
  }

  void _getImageDimension() {
    Image image = Image.network(widget.ImageSrc);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          setState(() {
            imageSize =
                Size(myImage.width.toDouble(), myImage.height.toDouble());
          });
        },
      ),
    );
  }
}

class SomeDialog extends StatefulWidget {
  final String Url;
  final Uint8List? imageToCrop;
  const SomeDialog({required this.Url, required this.imageToCrop});
  @override
  State<SomeDialog> createState() => _SomeDialogState();
}

class _SomeDialogState extends State<SomeDialog> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  Uint8List? _croppedImage;
  final OverlayType _overlayType = OverlayType.circle;
  int _rotationTurns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Đổi ảnh đại diện'),
        leading: Center(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Huỷ', style: TextStyle(fontSize: 14))),
        ),
        backgroundColor: Colors.black54,
      ),

      body: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
              child: Container(
                color: Colors.black87,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Cropper(
                  overlayColor: Colors.black54,
                  cropperKey: _cropperKey,
                  overlayType: _overlayType,
                  rotationTurns: _rotationTurns,
                  image: Image.memory(widget.imageToCrop!),
                  onScaleStart: (details) {
                    // todo: define started action.
                  },
                  onScaleUpdate: (details) {
                    // todo: define updated action.
                  },
                  onScaleEnd: (details) {
                    // todo: define ended action.
                  },
                ),
              ),
              flex: 5,
            ),
            Container(
                height: 90,
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  width: double.infinity,
                  color: Colors.black,
                  child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() => _rotationTurns--);
                                },
                                icon: const Icon(Icons.rotate_left),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() => _rotationTurns++);
                                },
                                icon: const Icon(Icons.rotate_right),
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,

                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  minimumSize: Size(170, 40), //////// HERE
                                ),
                                onPressed: () async {
                                  final imageBytes = await Cropper.crop(
                                    cropperKey: _cropperKey,
                                  );

                                  final tempDir = await getTemporaryDirectory();
                                  File file = await File(
                                          '${tempDir.path}/image_avatar.png')
                                      .create();
                                  file.writeAsBytesSync(imageBytes!);
                                  ref
                                      .read(profileProvider.notifier)
                                      .updateProfileAvatar(
                                          idUser: ref
                                              .watch(authProvider)
                                              .authUserModel!
                                              .id,
                                          file: file);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('XÁC NHẬN'),
                              );
                            },
                          )
                        ],
                      )),
                )),
          ])),
      // bottomSheet: yourWidget(),
    );
  }
}
