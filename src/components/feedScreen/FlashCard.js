import { View, Text } from "react-native";
import React, { useState } from "react";
import { StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native";

export default function FlashCard({ word, mean }) {
  const [title, setTitle] = useState(word);
  return (
    <TouchableOpacity
      onPress={() => setTitle((prev) => (prev === word ? mean : word))}
      style={flashCardStyle.container}
    >
      <Text style={flashCardStyle.title}>{title}</Text>
    </TouchableOpacity>
  );
}
const flashCardStyle = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
    borderRadius: 10,
    justifyContent: "center",
    alignItems: "center",
    padding: 30,
  },
  title: { fontWeight: "bold", fontSize: 30 },
});
