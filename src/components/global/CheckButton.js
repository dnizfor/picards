import { TouchableOpacity, StyleSheet } from "react-native";

import React from "react";
import { AntDesign } from "@expo/vector-icons";
export default function CheckButton({ onPress }) {
  return (
    <TouchableOpacity style={checkButtonStyle.container} onPress={onPress}>
      <AntDesign name="check" size={24} color="white" />
    </TouchableOpacity>
  );
}

const checkButtonStyle = StyleSheet.create({
  container: {
    width: 50,
    height: 50,
    backgroundColor: "#007bff",
    borderRadius: 25,
    justifyContent: "center",
    alignItems: "center",
  },
});
