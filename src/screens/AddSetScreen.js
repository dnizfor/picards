import { View, Text } from "react-native";
import React, { useState } from "react";
import { TextInput } from "react-native-gesture-handler";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import { StyleSheet } from "react-native";
import NewCard from "../components/addSetScreen/NewCard";

export default function AddSetScreen() {
  const [text, onChangeText] = useState("");

  return (
    <SafeAreaView style={addSetScreenStyle.container}>
      <TextInput
        onChangeText={onChangeText}
        value={text}
        style={addSetScreenStyle.textInput}
        placeholder="Set Name"
      />
      <View style={addSetScreenStyle.plusButtonContainer}>
        <PlusButton />
      </View>
      <View style={addSetScreenStyle.titleContainer}>
        <Text style={addSetScreenStyle.title}>Cards:</Text>
      </View>
      <NewCard />
    </SafeAreaView>
  );
}

const addSetScreenStyle = StyleSheet.create({
  container: {
    position: "relative",
    flex: 1,
    alignItems: "center",
    padding: 20,
  },
  textInput: {
    backgroundColor: "white",
    width: 300,
    height: 50,
    borderRadius: 25,
    textAlign: "center",
    fontWeight: "bold",
    fontSize: 15,
    borderBottomColor: "black",
    borderBottomWidth: 1,
    paddingHorizontal: 20,
  },
  plusButtonContainer: {
    position: "absolute",
    right: 20,
    bottom: 20,
  },
  titleContainer: {
    alignItems: "flex-start",
    width: 300,
    paddingVertical: 20,
  },
  title: {
    fontWeight: "bold",
  },
});
