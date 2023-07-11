import { Text } from "react-native";
import React from "react";
import { StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native";

export default function SetCard({ onPress, title, count }) {
  return (
    <TouchableOpacity onPress={onPress} style={setCardStyle.container}>
      <Text style={setCardStyle.title}>{title}</Text>
      <Text style={setCardStyle.count}>{count}</Text>
    </TouchableOpacity>
  );
}

const setCardStyle = StyleSheet.create({
  container: {
    width: 300,
    height: 100,
    borderRadius: 20,
    backgroundColor: "white",
    marginVertical: 10,
    justifyContent: "center",
    paddingHorizontal: 20,
  },
  title: { fontSize: 25, fontWeight: "bold" },
  count: { fontSize: 15, fontWeight: "bold", color: "grey" },
});
