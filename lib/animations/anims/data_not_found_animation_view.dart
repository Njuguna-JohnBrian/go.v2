import 'package:go/animations/anims/lottie_animation_view.dart';
import 'package:go/animations/lottie_animation.dart';


class DataNotFoundAnimationView extends LottieAnimationView {
  const DataNotFoundAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.dataNotFound,
        );
}
