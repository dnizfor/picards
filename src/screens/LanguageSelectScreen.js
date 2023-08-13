import React from "react";
import { Dimensions, Text, View, StyleSheet } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import LanguagePicker from "../components/languageSelectScreen/LanguagePicker";
const windowWidth = Dimensions.get("window").width;

const data = [
  {
    title: "Afrikaans",
    language: "af",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Arabic",
    language: "ar",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Bulgarian",
    language: "bg",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Bengali",
    language: "bn",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Bosnian",
    language: "bs",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Catalan",
    language: "ca",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Czech",
    language: "cs",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Danish",
    language: "da",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "German",
    language: "de",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Greek",
    language: "el",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "English",
    language: "en",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Spanish",
    language: "es",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Estonian",
    language: "et",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Finnish",
    language: "fi",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "French",
    language: "fr",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Gujarati",
    language: "gu",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Hindi",
    language: "hi",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Croatian",
    language: "hr",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Hungarian",
    language: "hu",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Indonesian",
    language: "id",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Icelandic",
    language: "is",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Italian",
    language: "it",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Hebrew",
    language: "iw",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Japanese",
    language: "ja",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Javanese",
    language: "jw",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Khmer",
    language: "km",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Kannada",
    language: "kn",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Korean",
    language: "ko",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Latin",
    language: "la",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Latvian",
    language: "lv",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Malayalam",
    language: "ml",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Marathi",
    language: "mr",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Malay",
    language: "ms",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Myanmar (Burmese)",
    language: "my",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Nepali",
    language: "ne",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Dutch",
    language: "nl",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Norwegian",
    language: "no",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Polish",
    language: "pl",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Portuguese",
    language: "pt",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Romanian",
    language: "ro",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Russian",
    language: "ru",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Sinhala",
    language: "si",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Slovak",
    language: "sk",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Albanian",
    language: "sq",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Serbian",
    language: "sr",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Sundanese",
    language: "su",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Swedish",
    language: "sv",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Swahili",
    language: "sw",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Tamil",
    language: "ta",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Telugu",
    language: "te",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Thai",
    language: "th",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Filipino",
    language: "tl",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Turkish",
    language: "tr",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Ukrainian",
    language: "uk",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Urdu",
    language: "ur",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Vietnamese",
    language: "vi",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Chinese (Simplified)",
    language: "zh-CN",
    imageSource: require("../assets/images/languages.png"),
  },
  {
    title: "Chinese (Traditional)",
    language: "zh-TW",
    imageSource: require("../assets/images/languages.png"),
  },
];

const LanguageSelectScreen = ({ onPress }) => {
  const onSelect = async (selectedItem) => {
    try {
      const jsonValue = JSON.stringify(selectedItem);
      await AsyncStorage.setItem("nativeLanguage", jsonValue);
      onPress();
    } catch (e) {
      // saving error
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Language</Text>
      <Text style={styles.subtitle}>
        Please select your native language. We will translate the contents into
        your language so that you can learn English.
      </Text>
      <LanguagePicker
        initialIndex={1}
        languageItemProps={{
          activeBorderColor: "#007bff",
        }}
        data={data}
        onSelect={onSelect}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingTop: 50,
    backgroundColor: "#EFEFEF",
  },
  title: {
    textAlign: "center",
    fontWeight: "600",
    fontSize: 26,
    color: "#454A62",
    marginTop: 32,
    marginBottom: 30,
  },
  subtitle: {
    width: windowWidth * 0.7,
    textAlign: "center",
    fontWeight: "500",
    fontSize: 13,
    color: "#2F3452",
    marginBottom: 40,
  },
});

export default LanguageSelectScreen;
