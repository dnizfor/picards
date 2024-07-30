import "react-native-gesture-handler";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { useEffect, useState } from "react";
import LanguageSelectScreen from "./src/screens/LanguageSelectScreen.js";
import OnboardingScreen from "./src/screens/OnboardingScreen.js";
import AsyncStorage from "@react-native-async-storage/async-storage";
import TabNavigator from "./src/routes/TabNavigator.js";
import { SQLiteProvider  } from 'expo-sqlite';

export default function App() {
  const [nativeIsSelected, setNativeIsSelected] = useState(false);
  const [isFirst, setIsFirst] = useState(false);
  useEffect(() => {
    AsyncStorage.getItem("nativeLanguage").then((res) =>
      res ? setNativeIsSelected(true) : setNativeIsSelected(false)
    ).catch(error=>console.log(error))

    AsyncStorage.getItem("isFirst").then((res) =>
      res ? setIsFirst(false) : setIsFirst(true)
    ).catch(error=>console.log(error))


 
    
  }, []);

  const onboardingOnPass = () => {
    setIsFirst((prev) => !prev);
    AsyncStorage.setItem("isFirst", "it is not first").then(()=>console.log("err")).catch(err=>console.log(err))
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
        <SQLiteProvider databaseName="vocabulary.db" >
        <TabNavigator />
        </SQLiteProvider>
      </SafeAreaProvider>
    );
  }
}
