import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/Home/Components/Advicess.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_cubit.dart';
import '../../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_state.dart';
import '../../../Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import '../../../Data/cubit/send_chat_cubit/send_chat_state.dart';
import '../../../Data/models/advice_models/show_advice_model.dart';
import '../../widgets/shared.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.showAdData, this.isAdviceDetail = false});

  final ShowAdData? showAdData;
  final bool isAdviceDetail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  String? fileSelected;
  String? voiceSelected;
  File? pickedFile;
  @override
  void initState() {
    super.initState();
    context.read<ShowAdviceCubit>().show(id: widget.showAdData!.id!);
    context.read<SendChatCubit>().emit(SendChatInitial());
  }

  @override
  void dispose() {
    super.dispose();
    messageController.clear();
    player.dispose();
  }

  final record = AudioRecorder();
  File? voiceFile;
  bool isRecording = false;
  Timer? countdownTimer;

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  void startRecord() async {
    await openTheRecorder();
    startTimer();
    String uniqueKey = const Uuid().v4() +
        DateTime.now().toIso8601String().replaceAll('.', '-');
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    if (Platform.isIOS) {
      voiceFile = File('$tempPath/$uniqueKey.m4a');
    } else {
      voiceFile = File('$tempPath/$uniqueKey.mp3');
    }
    record.stop();
    // timer;
    record.start(const RecordConfig(), path: voiceFile!.path).then((value) {
      isRecording = true;
      setState(() {});
    }).onError((error, stackTrace) {
      isRecording = false;
    });
  }

  stopRecord() async {
    countdownTimer?.cancel();
    await record.stop();
    isRecording = false;
    if (voiceFile!.existsSync()) {
      List<int> imageBytes = File(voiceFile!.path).readAsBytesSync();
      voiceSelected = base64.encode(imageBytes);
    }

    setState(() {});
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted && await record.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }
    }
  }

  final player = AudioPlayer();

  int playingIndex = -1;

  Future<void> playAudioFromUrl(String url, int index) async {
    if (playingIndex == index) {
      await player.stop();
      setState(() {
        playingIndex = -1; // Reset playingIndex
      });
    } else {
      await player.play(UrlSource(url));

      player.onPlayerComplete.listen((event) {
        setState(() {
          playingIndex = -1; // Reset playingIndex
        });
      });

      setState(() {
        playingIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
            backgroundColor: Constants.whiteAppColor,
            appBar: AppBar(
                centerTitle: false,
                leadingWidth: 70,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.showAdData?.client?.fullName ?? ""),
                        Text(
                          widget.showAdData?.date ?? "",
                          style: Constants.subtitleFont
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      logoColor,
                      color: Constants.primaryAppColor,
                      height: 50,
                    )
                  ],
                ),
                leading: MyBackButton(
                  hasValue: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: BlocListener<SendChatCubit, SendChatState>(
              listener: (context, state) {
                if (state is SendChatLoaded) {
                  context
                      .read<ShowAdviceCubit>()
                      .show(id: widget.showAdData!.id!);
                  fileSelected = null;
                  pickedFile = null;
                  voiceSelected = null;
                  messageController.clear();
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildAdviceWidget(),
                    Expanded(
                        child: BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                      buildWhen: (previous, current) {
                        return current is! ShowAdviceLoading;
                      },
                      builder: (context, state) {
                        if (state is ShowAdviceLoaded) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListView.builder(
                                reverse: true,
                                itemCount: state.response?.data?.chat?.length,
                                itemBuilder: (context, index) =>
                                    buildAlign(state, index, context),
                              ));
                        } else if (state is ShowAdviceError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )),
                    widget.showAdData!.label!.id == 1 ||
                            widget.showAdData!.label!.id == 2
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              left: 16,
                              right: 16,
                            ),
                            child: Column(
                              children: [
                                if (voiceSelected != null)
                                  Row(
                                    children: [
                                      buildVoiceShapeWidget(context),
                                    ],
                                  ),
                                if (pickedFile != null)
                                  pickedFile!.path.endsWith('.pdf')
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  height: 50,
                                                  width: width(context),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          offset: const Offset(
                                                            5.0,
                                                            5.0,
                                                          ),
                                                          blurRadius: 10.0,
                                                          spreadRadius: 2.0,
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    children: [
                                                      const Spacer(),
                                                      Text(pickedFile!.path
                                                          .replaceRange(
                                                              0, 56, "")),
                                                      const SizedBox(
                                                        width: 10
                                                      ),
                                                      SvgPicture.asset(
                                                        filePdf,
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    ],
                                                  )

                                                  // SfPdfViewer.file(
                                                  //   pickedFile!,
                                                  // ),
                                                  ),
                                            ),
                                            if (pickedFile != null)
                                              IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  setState(() {
                                                    pickedFile = null;
                                                  });
                                                },
                                              ),
                                          ],
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          height: 50,
                                          width: width(context),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                pickedFile!.path,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                              )),
                                              const SizedBox(width: 5),
                                              SvgPicture.asset(
                                                fileImage,
                                                width: 25,
                                                height: 25,
                                              ),
                                              if (pickedFile != null)
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(
                                                          Icons.close),
                                                      onPressed: () {
                                                        setState(() {
                                                          pickedFile = null;
                                                          fileSelected = null;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )),
                                const SizedBox(width: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        onTap: () {
                                          if (messageController.selection ==
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: messageController
                                                              .text.length -
                                                          1))) {
                                            messageController.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: messageController
                                                      .text.length),
                                            );
                                          }
                                        },
                                        controller: messageController,
                                        decoration:
                                            Constants.setTextInputDecoration(
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles();
                                                    // type:
                                                    // FileType.custom;
                                                    // allowedExtensions:
                                                    // ['pdf', 'jpg', 'png', "doc", "docx", "gif"];
                                                    if (result != null) {
                                                      setState(() {
                                                        pickedFile = File(result
                                                            .files
                                                            .single
                                                            .path!);
                                                      });
                                                      List<int> imageBytes =
                                                          File(pickedFile!.path)
                                                              .readAsBytesSync();
                                                      fileSelected = base64
                                                          .encode(imageBytes);
                                                    }
                                                    return;
                                                  },
                                                  child: SvgPicture.asset(
                                                      attachFiles)),
                                              const SizedBox(width: 8),
                                              isRecording
                                                  ? InkWell(
                                                      onTap: () {
                                                        stopRecord();
                                                      },
                                                      child: const Icon(Icons
                                                          .stop_circle_outlined))
                                                  : InkWell(
                                                      onTap: startRecord,
                                                      child: SvgPicture.asset(
                                                          micee)),
                                              const SizedBox(
                                                width: 8,
                                              )
                                            ],
                                          ),
                                          hintText: isRecording
                                              ? "جارِ التسجيل  ${countdownTimer?.tick}  ثواني ..... "
                                              : "اكتب رسالتك...",
                                        ).copyWith(
                                          hintStyle: Constants
                                              .subtitleRegularFontHint
                                              .copyWith(
                                                  color:
                                                      const Color(0XFF5C5E6B)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            gapPadding: 0,
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffF5F4F5),
                                        ),
                                      ),
                                    ),
                                    if (!isRecording) buildRecordingWidget()
                                  ],
                                ),
                              ],
                            ),
                          )
                        : cantSpeakWidget(context),
                  ],
                ),
              ),
            )));
  }

  BlocBuilder<ShowAdviceCubit, ShowAdviceState> buildRecordingWidget() {
    return BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
      builder: (context, state2) {
        return BlocBuilder<SendChatCubit, SendChatState>(
          builder: (context, state3) {
            return GestureDetector(
              onTap: () {
                if (state2 is ShowAdviceLoading || state3 is SendChatLoading) {
                  return;
                }

                MyApplication.dismissKeyboard(context);

                if (fileSelected != null) {
                  context.read<SendChatCubit>().sendChatFunction(
                      filee: fileSelected,
                      msg: messageController.text,
                      typee: pickedFile?.path.split(".").last,
                      adviceId: widget.showAdData!.id.toString());

                  fileSelected = null;
                } else if (voiceFile != null) {
                  context.read<SendChatCubit>().sendChatFunction(
                      filee: voiceSelected,
                      msg: messageController.text,
                      typee: voiceFile!.path.split(".").last,
                      adviceId: widget.showAdData!.id.toString());
                  // isRecording = false;
                  setState(() {
                    voiceSelected = null;
                    voiceFile = null;
                  });
                } else if (messageController.text.isNotEmpty) {
                  context.read<SendChatCubit>().sendChatFunction(
                      filee: fileSelected,
                      msg: messageController.text,
                      adviceId: widget.showAdData!.id.toString());
                }
              },
              child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 8),
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XFF273043)),
                  child: state3 is SendChatLoading?
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ))
                      : SvgPicture.asset(
                          sendChat,
                        )),
            );
          },
        );
      },
    );
  }

  buildVoiceShapeWidget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        // width: width(context),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SvgPicture.asset(voiceShape),
            if (voiceFile != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        voiceFile = null;
                        voiceSelected = null;
                      });
                    },
                  ),
                ),
              ),
          ],
        ));
  }

  Align buildAlign(ShowAdviceLoaded state, int index, BuildContext context) {
    return Align(
      alignment: state.response?.data?.chat?[index].adviser == null
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: state.response?.data?.chat?[index].mediaType == "1"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.response?.data?.chat?[index].message == null
                    ? const SizedBox()
                    : Container(
                        constraints: const BoxConstraints(maxWidth: 220),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: state.response?.data?.chat?[index].adviser ==
                                    null
                                ? const Color.fromARGB(255, 185, 184, 180)
                                    .withOpacity(0.2)
                                : Constants.primaryAppColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20)),
                        child: Linkify(
                          onOpen: (value) {
                            launchUrl(Uri.parse(value.url));
                          },
                          text:
                              state.response?.data?.chat?[index].message ?? "",
                          style: Constants.subtitleFont,
                        )),
                InkWell(
                  onTap: () {
                    if (state.response?.data!.chat?[index].document![0].file
                                ?.contains('png') ==
                            true ||
                        state.response?.data!.chat?[index].document![0].file
                                ?.contains('jpeg') ==
                            true ||
                        state.response?.data!.chat?[index].document![0].file
                                ?.contains('jpg') ==
                            true) {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                              content: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Center(
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        '${state.response!.data!.chat![index].document![0].file}'),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      launchUrl(Uri.parse(state
                              .response?.data?.chat?[index].document?[0].file ??
                          ""));
                    }
                  },
                  child: Container(
                    width: width(context) * 0.7,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: state.response?.data?.chat?[index].document?[0].file
                                ?.endsWith("mp3") ??
                            false
                        ? InkWell(
                            onTap: () => playAudioFromUrl(
                              state.response?.data?.chat?[index].document?[0]
                                      .file ??
                                  "",
                              index,
                            ),
                            child: playingIndex == index
                                ? audioPlayingWidget()
                                : audioStopWidget(),
                          )
                        : state.response?.data?.chat?[index].document?[0].file
                                    ?.endsWith("m4a") ??
                                false
                            ? InkWell(
                                onTap: () => playAudioFromUrl(
                                  state.response?.data?.chat?[index]
                                          .document?[0].file ??
                                      "",
                                  index,
                                ),
                                child: playingIndex == index
                                    ? audioPlayingWidget()
                                    : audioStopWidget(),
                              )
                            : buildImageDetailsWidget(state, index),
                  ),
                ),
              ],
            )
          : Container(
              constraints: const BoxConstraints(maxWidth: 220),
              // width: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              // constraints: BoxConstraints(mi),
              decoration: BoxDecoration(
                  color: state.response?.data?.chat?[index].adviser == null
                      ? const Color.fromARGB(255, 185, 184, 180)
                          .withOpacity(0.2)
                      : Constants.primaryAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
              child: Linkify(
                onOpen: (value) {
                  launchUrl(Uri.parse(value.url));
                },
                text: state.response?.data?.chat?[index].message ?? "",
                style: Constants.subtitleFont,
              )),
    );
  }

  Row buildImageDetailsWidget(ShowAdviceLoaded state, int index) {
    return Row(
      children: [
        state.response?.data?.chat?[index].document?[0].file?.endsWith("png") ??
                false
            ? SvgPicture.asset(photo)
            : state.response?.data?.chat?[index].document?[0].file
                        ?.endsWith("jpg") ??
                    false
                ? SvgPicture.asset(photo)
                : state.response?.data?.chat?[index].document?[0].file
                            ?.endsWith("jpeg") ??
                        false
                    ? SvgPicture.asset(photo)
                    : state.response?.data?.chat?[index].document?[0].file
                                ?.endsWith("pdf") ??
                            false
                        ? SvgPicture.asset(pdf)
                        : state.response?.data?.chat?[index].document?[0].file
                                    ?.endsWith("mp4") ??
                                false
                            ? SvgPicture.asset(mp4Icon)
                            : const SizedBox.shrink(),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            state.response?.data?.chat?[index].document?[0].file
                    ?.split("/")
                    .last ??
                "",
            style: Constants.subtitleFont,
          ),
        ),
      ],
    );
  }

  Row audioStopWidget() {
    return Row(
      children: [
        SizedBox(
          height: 40,
          width: 210,
          child: SvgPicture.asset(voiceShape, fit: BoxFit.fill),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
            backgroundColor: Constants.primaryAppColor,
            child: SvgPicture.asset(voice)),
      ],
    );
  }

  Row audioPlayingWidget() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 40,
        width: 210,
        child: Image.asset('assets/images/PNG/gifnasoh.gif', fit: BoxFit.fill),
      ),
      const SizedBox(width: 10),
      const CircleAvatar(
          backgroundColor: Constants.primaryAppColor,
          child: Icon(Icons.pause, color: Colors.white)),
    ]);
  }

  Padding buildAdviceWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AdviceWidget(
        showAdData: widget.showAdData,
        isAdviceDetail: widget.isAdviceDetail,
      ),
    );
  }
}

Container cantSpeakWidget(BuildContext context) {
  return Container(
    height: 90,
    width: width(context),
    color: Constants.primaryAppColor.withOpacity(0.1),
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          "لا يمكنك التحدث مع هذا المنصوح الان",
          style: TextStyle(fontSize: 12, fontFamily: Constants.mainFont),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            "العودة الي الرئيسة",
            style: TextStyle(
                color: Constants.primaryAppColor,
                fontFamily: Constants.mainFont),
          ),
        )
      ],
    ),
  );
}
