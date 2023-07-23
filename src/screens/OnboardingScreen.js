import React from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import Onboarding from "react-native-onboarding-swiper";
import { Image } from "react-native";
export default function OnboardingScreen({ onDone, onSkip }) {
  return (
    <Onboarding
      pages={[
        {
          backgroundColor: "#fff",
          image: <Image source={require("../assets/images/movies.png")} />,
          title: "Learn English! ",
          subtitle: "Learn English With Movies and TV Shows!",
        },
        {
          backgroundColor: "#fff",
          image: <Image source={require("../assets/images/vocabulary.png")} />,
          title: "Vocabulary",
          subtitle: "Learn new words with movies!",
        },
        {
          backgroundColor: "#fff",
          image: <Image source={require("../assets/images/listening.png")} />,
          title: "Listening!",
          subtitle: "Practice listening with arrays and movies!",
        },
      ]}
      onDone={onDone}
      onSkip={onSkip}
    />
  );
}
