import React from "react";
import { Dimensions, Text, View } from "react-native";
import LanguagePicker from "react-native-language-select";

const windowWidth = Dimensions.get("window").width;

const data = [
  {
    title: "English",
    language: "en",
  },
  {
    title: "Italian",
  },
  {
    title: "German",
  },
  {
    title: "Turkish",
    language: "tr",
  },
  {
    title: "Swedish",
  },
  {
    title: "Japanese",
  },
];

const LanguageSelectScreen = () => {
  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
        paddingTop: 50,
        backgroundColor: "#EFEFEF",
      }}
    >
      <Text
        style={{
          textAlign: "center",
          fontWeight: "600",
          fontSize: 26,
          color: "#454A62",
          marginTop: 32,
          marginBottom: 30,
        }}
      >
        Language
      </Text>
      <Text
        style={{
          width: windowWidth * 0.7,
          textAlign: "center",
          fontWeight: "500",
          fontSize: 13,
          color: "#2F3452",
          marginBottom: 40,
        }}
      >
        Please select your native language. We will translate the contents into
        your language so that you can learn English.
      </Text>
      <LanguagePicker
        initialIndex={1}
        languageItemProps={{
          activeBorderColor: "red",
        }}
        data={data}
        onSelect={(selectedItem) => {
          console.log(selectedItem);
        }}
      />
    </View>
  );
};

export default LanguageSelectScreen;
