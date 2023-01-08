import 'package:go/animations/anims/lottie_animation_view.dart';
import 'package:go/animations/lottie_animation.dart';


class EmptyContentAnimationView extends LottieAnimationView {
  const EmptyContentAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.empty,
        );
}
