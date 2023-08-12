import "react-native-gesture-handler";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { useEffect, useState } from "react";
import { initializeDatabase } from "./src/utils/dbController.js";
import LanguageSelectScreen from "./src/screens/LanguageSelectScreen.js";
import OnboardingScreen from "./src/screens/OnboardingScreen.js";
import AsyncStorage from "@react-native-async-storage/async-storage";
import TabRoutes from "./src/routes/TabRoutes.js";

export default function App() {
  const [nativeIsSelected, setNativeIsSelected] = useState(false);
  const [isFirst, setIsFirst] = useState(false);
  useEffect(() => {
    initializeDatabase();
    AsyncStorage.getItem("nativeLanguage").then((res) =>
      res ? setNativeIsSelected(true) : setNativeIsSelected(false)
    );

    AsyncStorage.getItem("isFirst").then((res) =>
      res ? setIsFirst(false) : setIsFirst(true)
    );
  }, []);

  const onboardingOnPass = () => {
    setIsFirst((prev) => !prev);
    AsyncStorage.setItem("isFirst", "it is not first");
  };
  if (!nativeIsSelected) {
    return (
      <LanguageSelectScreen
        onPress={() => setNativeIsSelected((prev) => !prev)}
      />
    );
  } else if (isFirst)
    return (
      <OnboardingScreen onDone={onboardingOnPass} onSkip={onboardingOnPass} />
    );
  else {
    return (
      <SafeAreaProvider>
        <TabRoutes />
      </SafeAreaProvider>
    );
  }
}
