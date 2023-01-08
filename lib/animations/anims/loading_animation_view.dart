import 'package:go/animations/anims/lottie_animation_view.dart';
import 'package:go/animations/lottie_animation.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({
    super.key,
  }) : super(
          animation: LottieAnimation.loading,
        );
}
