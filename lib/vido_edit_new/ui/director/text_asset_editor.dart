import 'dart:core';
import 'package:demo_chat/vido_edit_new/ui/director/params.dart';
import 'package:demo_chat/vido_edit_new/ui/director/text_form.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../service/director_service.dart';
import '../../service_locator.dart';


class TextAssetEditor extends StatelessWidget {
  final directorService = locator.get<DirectorService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: directorService.editingTextAsset$,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Asset> editingTextAsset) {
          if (editingTextAsset.data == null) return Container();
          return Container(
            height: Params.getTimelineHeight(context),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border(
                top: BorderSide(width: 2, color: Colors.blue),
              ),
            ),
            child: TextForm(editingTextAsset.data),
          );
        });
  }
}
