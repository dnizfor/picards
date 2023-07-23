import { View, Text, Image, StyleSheet } from "react-native";
import React, { useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import UserImage from "../assets/images/user.png";
import LanguageCard from "../components/settingsScreen/LanguageCard";
import AsyncStorage from "@react-native-async-storage/async-storage";
import LanguageSelectScreen from "./LanguageSelectScreen";

export default function SettingsScreen() {
  const [language, setLanguage] = useState("");
  const [languageSelectIsOpen, setLanguageSelectIsOpen] = useState(false);
  useState(() => {
    AsyncStorage.getItem("nativeLanguage").then((res) =>
      setLanguage(JSON.parse(res).title)
    );
  }, []);
  if (languageSelectIsOpen)
    return (
      <LanguageSelectScreen onPress={() => setLanguageSelectIsOpen(false)} />
    );
  return (
    <SafeAreaView style={settingsScreenStyle.container}>
      <View style={settingsScreenStyle.header}>
        <Image source={UserImage} />
      </View>
      <View style={settingsScreenStyle.bottomContainer}>
        <View>
          <Text style={settingsScreenStyle.title}>Native Language</Text>
          <LanguageCard
            title={language}
            onPress={() => setLanguageSelectIsOpen(true)}
          />
        </View>
        <Text style={settingsScreenStyle.title}>Target Language</Text>
        <LanguageCard title={"English"} />
      </View>
    </SafeAreaView>
  );
}
const settingsScreenStyle = StyleSheet.create({
  container: { flex: 1, padding: 20 },
  header: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  bottomContainer: { flex: 2 },
  title: {
    fontWeight: "bold",
    marginTop: 10,
  },
});
