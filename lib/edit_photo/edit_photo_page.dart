import 'dart:async';

import 'package:demo_chat/edit_photo/status_download.dart';
import 'package:demo_chat/edit_photo/view/edit_photo_view.dart';
import 'package:demo_chat/edit_photo/widget/dragable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import 'cubit/edit_photo_cubit.dart';
import 'menu/add text/add_text_page.dart';
import 'menu/delete_text/delete_text_dialog.dart';

class EditPhotoPage extends StatelessWidget {
  EditPhotoPage({Key? key}) : super(key: key);
  StreamController<WidgetState> backbuttonstate = StreamController.broadcast();
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    // final Photo photo = ModalRoute.of(context)?.settings.arguments as Photo;


    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
        // final result = await showDialogConfirmationToExit(context);
        // return result;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder(builder: (context, snapshot){
              return Screenshot(
                controller: screenshotController,
                child: const EditPhotoView(),
              );
            } ),
           /* BlocListener<EditPhotoCubit, EditPhotoState>(
              listener: (context, state) {
                *//*if (state.statusDownload == StatusDownload.downloading) {
                  showDialogLoading(context);
                }

                if (state.statusDownload == StatusDownload.success) {
                  /// close loading dialog
                  Navigator.pop(context);
                  showInfoDialog(
                    context,
                    "Saved",
                    Icons.check_circle_outline_rounded,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }

                if (state.statusDownload == StatusDownload.failed) {
                  /// close loading dialog
                  Navigator.pop(context);

                  showInfoDialog(
                    context,
                    "Failed",
                    Icons.info_outline,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }

                if (state.statusShare == StatusDownload.downloading) {
                  showDialogLoading(context);
                }

                if (state.statusShare == StatusDownload.success) {
                  /// close loading dialog
                  Navigator.pop(context);
                }

                if (state.statusShare == StatusDownload.failed) {
                  /// close loading dialog
                  Navigator.pop(context);

                  showInfoDialog(
                    context,
                    "Failed",
                    Icons.info_outline,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pop(context);
                  });
                }*//*
              },
              listenWhen: (p, c) {
                final downloading = p.statusDownload != c.statusDownload;
                final sharing = p.statusShare != c.statusShare;

                return downloading || sharing;
              },
              child: Screenshot(
                controller: screenshotController,
                child: const EditPhotoView(),
              ),
            ),*/
            StreamBuilder<WidgetState>(
              stream: backbuttonstate.stream,
              initialData: WidgetState.editing,
              builder: (context, snapshot) {
                return Positioned(
                  left: 20,
                  top: MediaQuery.of(context).padding.top + 20,
                  child:Visibility(
                    visible: snapshot.data != WidgetState.editing,
                    maintainState: true,
                    child: iconButton(
                      onTap: () async {
                        // final result = await showDialogConfirmationToExit(
                        //   context,
                        // );
                        // if (result == null) return;
                        //
                        // if (result) {
                        Navigator.pop(context);
                        // }
                      },
                      icon: Icons.arrow_back_ios_new_rounded,
                    ),
                  ) /*BlocBuilder<EditPhotoCubit, EditPhotoState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state.widgetState != WidgetState.editing,
                        maintainState: true,
                        child: iconButton(
                          onTap: () async {
                            // final result = await showDialogConfirmationToExit(
                            //   context,
                            // );
                            // if (result == null) return;
                            //
                            // if (result) {
                              Navigator.pop(context);
                            // }
                          },
                          icon: Icons.arrow_back_ios_new_rounded,
                        ),
                      );
                    },
                  )*/,
                );
              }
            ),
            StreamBuilder<WidgetState>(
                stream: backbuttonstate.stream,
                initialData: WidgetState.editing,
              builder: (context, snapshot) {
                return Positioned(
                  right: 20,
                  top: MediaQuery.of(context).padding.top + 20,
                  child:Visibility(
                    visible: snapshot.data != WidgetState.editing,
                    maintainState: true,
                    child: MenuAction(
                      screenshotController: screenshotController,
                    ),
                  ) /*BlocBuilder<EditPhotoCubit, EditPhotoState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state.widgetState != WidgetState.editing,
                        maintainState: true,
                        child: MenuAction(
                          screenshotController: screenshotController,
                        ),
                      );
                    },
                  )*/,
                );
              }
            ),
            Positioned(
              left: 20,
              top: MediaQuery.of(context).padding.top + 70,
              bottom: 80,
              child: RotatedBox(
                quarterTurns: 3,
                child: Visibility(
                  visible: true,
                  maintainState: true,
                  child: Slider(
                    value: 0.5,
                    min: 0,
                    max: 1,
                    onChanged:(val){

                    }/* context
                        .read<EditPhotoCubit>()
                        .updateLayerTrasparancy*/,
                  ),
                )/*BlocBuilder<EditPhotoCubit, EditPhotoState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.layerState == LayerState.editing,
                      maintainState: true,
                      child: Slider(
                        value: state.layerOpacity,
                        min: 0,
                        max: 1,
                        onChanged: context
                            .read<EditPhotoCubit>()
                            .updateLayerTrasparancy,
                      ),
                    );
                  },
                )*/,
              ),
            ),
             StreamBuilder<Object>(
               stream: backbuttonstate.stream,
               builder: (context, snapshot) {
                 return Positioned(
                  left: 20,
                  bottom: 20,
                  child:   Visibility(
                      visible: snapshot.data != WidgetState.editing,
                      child: MenuEdit(controller: backbuttonstate,))/*BlocBuilder<EditPhotoCubit, EditPhotoState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state.widgetState != WidgetState.editing,
                        maintainState: true,
                        child: const MenuEdit(),
                      );
                    },
                  )*/,
            );
               }
             ),
          ],
        ),
      ),
    );
  }
}

Widget iconButton({
  required Function() onTap,
  required IconData icon,
  double iconSize = 32,
  double buttonSize = 54,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: buttonSize,
      width: buttonSize,
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
    ),
  );
}

class MenuAction extends StatelessWidget {
  const MenuAction({
    Key? key,
    required this.screenshotController,
  }) : super(key: key);

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        iconButton(
          icon: Icons.download,
          onTap: () async {
            context
                .read<EditPhotoCubit>()
                .changeDownloadState(StatusDownload.downloading);

            final image = await screenshotController.capture();
            if (image == null) {
              context
                  .read<EditPhotoCubit>()
                  .changeDownloadState(StatusDownload.failed);

              return;
            }

            context.read<EditPhotoCubit>().downloadImage(image);
          },
        ),
        const SizedBox(width: 10),
        iconButton(
          icon: Icons.share,
          onTap: () async {
            context
                .read<EditPhotoCubit>()
                .changeShareState(StatusDownload.downloading);

            final image = await screenshotController.capture();
            if (image == null) {
              context
                  .read<EditPhotoCubit>()
                  .changeShareState(StatusDownload.failed);

              return;
            }

            context.read<EditPhotoCubit>().shareImage(image);
          },
        ),
      ],
    );
  }
}

class MenuEdit extends StatelessWidget {
  StreamController controller;
   MenuEdit({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        iconButton(
          icon: Icons.layers,
          onTap: (){

          }/*context.read<EditPhotoCubit>().editLayer*/,
        ),
        const SizedBox(width: 10),
        iconButton(
          icon: Icons.text_fields_rounded,
          onTap: () async {
            /// change state to editing
            // /// so the menu UI will not visible while add/edit text
            // context
            //     .read<EditPhotoCubit>()
            //     .changeWidgetState(WidgetState.editing);
            controller.add(WidgetState.editing);

            /// wait for text edit done / cancel
            final result = await addText(context) as DragableWidgetTextChild?;

            /// change state to idle
            /// so the menu UI will visible again
            controller.add(WidgetState.idle);
            context.read<EditPhotoCubit>().changeWidgetState(WidgetState.idle);

            /// if user cancel add/edit text do nothing
            if (result == null) return;

            /// unique key for identification in List<DragableWidget> on BLocState
            final uniqueKey = DateTime.now().millisecondsSinceEpoch;

            /// define dragable widget abse on results
            final widget = DragableWidget(
              key: UniqueKey(),
              uniqueKey: uniqueKey,
              child: result,
              onTap: (key, child) async {
                /// check if the child is [DragableWidgetTextChild]
                if (child is DragableWidgetTextChild) {
                  /// change state to editing
                  /// so the menu UI will not visible while add/edit text
                  // context
                  //     .read<EditPhotoCubit>()
                  //     .changeWidgetState(WidgetState.editing);
                  controller.add(WidgetState.editing);

                  /// wait for text edit done / cancel
                  final result = await addText(
                    context,
                    child,
                  ) as DragableWidgetTextChild?;

                  /// change state to idle
                  /// so the menu UI will visible again
                  // context
                  //     .read<EditPhotoCubit>()
                  //     .changeWidgetState(WidgetState.idle);
                  controller.add(WidgetState.idle);
                  /// if user cancel add/edit text do nothing
                  if (result == null) return;

                  /// edit dragable widget in List<DragableWidget>
                  context.read<EditPhotoCubit>().editWidget(key, result);
                }
              },
              onLongPress: (uniqueKey) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return dialogDeleteTextConfirmation(context, uniqueKey);
                  },
                );
              },
            );

            /// add dragable widget to List<DragableWidget>
            context.read<EditPhotoCubit>().addWidget(widget);
          },
        ),
      ],
    );
  }
}
