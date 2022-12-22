import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/providers/location/location_state_provider.dart';

class ViewScreen extends ConsumerStatefulWidget {
  const ViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ViewScreenState();
}

class _ViewScreenState extends ConsumerState<ViewScreen> {
  @override
  void initState() {
    ref.read(locationStateProvider.notifier).getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text("${ref.watch(locationStateProvider).currentLongitude}"),
      ),
    );
  }
}
