import { View, Text } from "react-native";
import React from "react";
import { TouchableOpacity } from "react-native";
import { StyleSheet } from "react-native";

export default function ChooseCard({ title, onPress }) {
  return (
    <TouchableOpacity style={ChooseCardStyle.container} onPress={onPress}>
      <Text style={ChooseCardStyle.title}>{title}</Text>
    </TouchableOpacity>
  );
}

const ChooseCardStyle = StyleSheet.create({
  container: {
    width: 200,
    height: 100,
    backgroundColor: "white",
    justifyContent: "center",
    alignItems: "center",
    marginVertical: 10,
    borderRadius: 20,
  },
  title: { fontSize: 30 },
});
