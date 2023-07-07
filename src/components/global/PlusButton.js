import { TouchableOpacity, StyleSheet } from "react-native";
import React from "react";
import { Feather } from "@expo/vector-icons";

export default function PlusButton({ onPress }) {
  return (
    <TouchableOpacity style={PlusButtonStyle.container} onPress={onPress}>
      <Feather name={"plus"} size={30} color={"white"} />
    </TouchableOpacity>
  );
}

const PlusButtonStyle = StyleSheet.create({
  container: {
    width: 50,
    height: 50,
    backgroundColor: "blue",
    borderRadius: 25,
    justifyContent: "center",
    alignItems: "center",
  },
});
