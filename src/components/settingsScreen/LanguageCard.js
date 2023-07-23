import { View, Text, Image } from "react-native";
import React from "react";
import { StyleSheet } from "react-native";
import LanguagesImage from "../../assets/images/languages.png";
import { TouchableOpacity } from "react-native";
export default function LanguageCard({ title, onPress }) {
  return (
    <TouchableOpacity onPress={onPress} style={languageCardStyle.container}>
      <View style={languageCardStyle.imageContainer}>
        <Image source={LanguagesImage} />
      </View>
      <View style={languageCardStyle.titleContainer}>
        <Text style={languageCardStyle.title}>{title}</Text>
      </View>
    </TouchableOpacity>
  );
}

const languageCardStyle = StyleSheet.create({
  container: {
    height: 100,
    flexDirection: "row",
    backgroundColor: "white",
    borderRadius: 25,
    marginVertical: 10,
  },
  imageContainer: {
    height: 100,
    width: "30%",
    justifyContent: "center",
    alignItems: "center",
  },
  titleContainer: {
    height: 100,
    width: "70%",
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 25,
  },
});
