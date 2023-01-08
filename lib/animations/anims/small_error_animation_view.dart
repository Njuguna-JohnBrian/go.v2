import 'package:go/animations/anims/lottie_animation_view.dart';
import 'package:go/animations/lottie_animation.dart';

class SmallErrorAnimationView extends LottieAnimationView {
  const SmallErrorAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.smallError,
        );
}
