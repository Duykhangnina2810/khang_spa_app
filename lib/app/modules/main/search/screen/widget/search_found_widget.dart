import 'package:app_example/app/modules/main/home/model/service_model.dart';
import 'package:app_example/app/modules/main/home/screen/widgets/dichvu_grid_widget.dart';
import 'package:flutter/material.dart';

class SearchFoundWidget extends StatelessWidget {
  const SearchFoundWidget({Key? key, required this.models}) : super(key: key);

  final List<ServiceModel> models;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          DichvuGridWidget(data: models, columnGap: 17, rowGap: 16, column: 2)
        ],
      ),
    );
  }
}
