import 'package:go/animations/anims/lottie_animation_view.dart';
import 'package:go/animations/lottie_animation.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.error,
        );
}
