import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';

import '../../../../services/investigation_service.dart';

class PickAttachments extends StatefulWidget {
  final Function(String)? imagePath;
  final int? investigationId;
  final UploadListener? listener;
  const PickAttachments(
      {Key? key, @required this.imagePath, this.investigationId, this.listener})
      : super(key: key);
  @override
  PickAttachmentsState createState() => PickAttachmentsState();
}

typedef UploadListener = void Function(bool isSuccess);

class PickAttachmentsState extends State<PickAttachments> {
  List<Object> images = [];
  Future<PickedFile?>? _imageFile;
  final picker = ImagePicker();
  String? path;
  String? msg;
  bool isLoading = false;

  Future _onAddImageClick(int index, int type) async {
    setState(() {
      _imageFile = picker.getImage(
        source: type == 1 ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      getFileImage(index);
    });
  }

  void getFileImage(int index) {
    if (_imageFile != null) {
      _imageFile!.then((file) {
        setState(() {
          ImageUploadModel imageUpload = ImageUploadModel();
          imageUpload.imageFile = File(file!.path);
          widget.imagePath!(file.path);
          path = file.path;
          images.replaceRange(index, index + 1, [imageUpload]);
        });
      });
    }
  }

  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path ?? '');
      path = file.path;

      debugPrint('===>>>${file.path}');
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: const Center(
                child: Text('Select Your Attachment',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                    children: List.generate(images.length, (index) {
                      var image = images[index];
                      if (image is ImageUploadModel) {
                        ImageUploadModel uploadModel = image;
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: <Widget>[
                              Image.file(
                                uploadModel.imageFile!,
                                fit: BoxFit.cover,
                                width: 600,
                                height: 600,
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      path = null;
                                      images.replaceRange(
                                          index, index + 1, ['Add Image']);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        String fileNm = image is String ? image : "";
                        return Card(
                          child: IconButton(
                            icon: fileNm.endsWith("Add File")
                                ? const Icon(
                                    Icons.file_upload,
                                    size: 50,
                                  )
                                : const Icon(Icons.camera_alt, size: 50),
                            onPressed: () {
                              fileNm.endsWith("Add File")
                                  ? pickFile(index)
                                  : showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Wrap(
                                            children: <Widget>[
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.photo_camera),
                                                title: const Text('Camera'),
                                                onTap: () {
                                                  _onAddImageClick(index, 1);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ListTile(
                                                  leading: const Icon(
                                                      Icons.photo_library),
                                                  title: const Text('Gallery'),
                                                  onTap: () {
                                                    _onAddImageClick(index, 2);
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            },
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: Image.asset(
                      'assets/images/loader.gif',
                      height: 100,
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            msg == null
                ? Container()
                : Text(
                    msg ?? '',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                btnColor: primaryColor,
                btnText: 'Send',
                onTap: () {
                  if (path == null) {
                    setState(() {
                      msg = "Please select attachment first";
                    });
                  } else {
                    setState(() {
                      msg = null;
                      isLoading = true;
                    });
                    InvestigationService()
                        .submitAttachment(path ?? '')
                        .then((value) {
                      debugPrint('--hi-- $value');
                      if (value.isNotEmpty && value["statusCode"] == 200) {
                        final mimeType = lookupMimeType(path ?? '');

                        String filePath = '';
                        try {
                          filePath = value["listResponse"][0]["filePath"];
                        } catch (e) {
                          filePath = '';
                          debugPrint("e: $e");
                        }
                        debugPrint("filePath: $filePath");

                        Map body = {
                          "P_INVSTGTNO": widget.investigationId,
                          "P_PHOTOLOCA": filePath,  
                          "P_MIMETYPES": mimeType
                        };
                        InvestigationService()
                            .submitAttachmentInfo(body)
                            .then((value) {
                          debugPrint("$value");
                          if (value['P_RETRNMSGN'] == '200') {
                            setState(() {
                              msg = value['P_RETRNMSG0'] ?? "";
                              widget.listener!(true);
                              Navigator.pop(context);
                            });
                          } else {
                            setState(() {
                              msg = "Upload failed";
                            });
                          }
                          setState(() {
                            isLoading = false;
                          });
                        });
                      } else {
                        setState(() {
                          print("object--------------------------");
                          msg = "Upload failed";
                          isLoading = false;
                        });
                      }
                    });
                  }
                  debugPrint('path--- $path');
                }),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class ImageUploadModel {
  File? imageFile;

  ImageUploadModel({
    this.imageFile,
  });
}
