import { View, Text } from "react-native";
import React, { useState } from "react";
import { StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native";

export default function FlashCard({ word, mean }) {
  const [title, setTitle] = useState(word);
  return (
    <View style={flashCardStyle.container}>
      <TouchableOpacity
        onPress={() => setTitle((prev) => (prev === word ? mean : word))}
        style={flashCardStyle.card}
      >
        <Text style={flashCardStyle.title}>{title}</Text>
      </TouchableOpacity>
    </View>
  );
}
const flashCardStyle = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#EFEFEF",
    padding: 20,
  },
  card: {
    flex: 1,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#54B4D3",
    padding: 20,
  },
  title: { fontWeight: "bold", fontSize: 30, color: "white" },
});
