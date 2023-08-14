import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globalfunction.dart';
import '../cubit/edit_photo_cubit.dart';
import 'base_photo.dart';


class EditPhotoView extends StatelessWidget {
  const EditPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: const [
        BasePhoto(),
        EditLayer(),
      ],
    ); /*BlocBuilder<EditPhotoCubit, EditPhotoState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: const [
            BasePhoto(),
            EditLayer(),
          ],
        );
      },
    );*/
  }
}

class EditLayer extends StatelessWidget {
  const EditLayer({Key? key}) : super(key: key);
  // EditPhotoCubit epc;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: datacontroller.stream,
      builder: (context, snapshot) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
              ),
            ),

            /// widgets
            for (var i = 0; i < Listwidgets.length; i++)
              Align(
                key: UniqueKey(),
                alignment: Alignment.center,
                child: Listwidgets[i],
              ),
          ],
        );
      }
    )
      /* BlocBuilder<EditPhotoCubit, EditPhotoState>(
      buildWhen: (p, c) {
        epc.state.Listwidgets;
        final changeOnWidgets = p.Listwidgets.length != c.Listwidgets.length;
        final editedWidget = p.widgetState != c.widgetState;
        final editedLayer = p.layerOpacity != c.layerOpacity;
        return changeOnWidgets || editedWidget || editedLayer;
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(state.layerOpacity),
              ),
            ),

            /// widgets
            for (var i = 0; i < state.Listwidgets.length; i++)
              Align(
                key: UniqueKey(),
                alignment: Alignment.center,
                child: state.Listwidgets[i],
              ),
          ],
        );
      },
    )*/;
  }
}
