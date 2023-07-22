import React from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import Onboarding from "react-native-onboarding-swiper";
import { Image } from "react-native";
export default function OnboardingScreen() {
  return (
    <Onboarding
      pages={[
        {
          backgroundColor: "#fff",
          image: <Image source={require("../assets/favicon.png")} />,
          title: "Onboarding",
          subtitle: "Done with React Native Onboarding Swiper",
        },
      ]}
    />
  );
}
