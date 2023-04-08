import 'package:flutter/material.dart';

import '../../model/service_model.dart';
import 'dichvu_item_widget.dart';

class DichvuGridWidget extends StatelessWidget {
  const DichvuGridWidget({Key? key, required this.data, required this.columnGap, required this.rowGap, required this.column}) : super(key: key);
  final List<ServiceModel> data;
  final double columnGap;
  final double rowGap;
  final int column;
  @override
  Widget build(BuildContext context) {
    final double colGap = (column > 1 ? (columnGap / (column - 1)) : 0);
    final maxScreenWidth = MediaQuery.of(context).size.width - 40;
    final itemWidht = (maxScreenWidth / column) - colGap;
    return Wrap(
      spacing: colGap,
      runSpacing: rowGap,
      children: data.map((e) => DichvuItemWidget(width: itemWidht, model: e)).toList(),
    );
  }
}
