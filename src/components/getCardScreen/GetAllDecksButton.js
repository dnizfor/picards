import { Text, StyleSheet, TouchableOpacity } from "react-native";
import React from "react";

export default function GetAllDecksButton({ onPress }) {
  return (
    <TouchableOpacity onPress={onPress} style={getDecksButtonStyle.container}>
      <Text style={getDecksButtonStyle.title}>Get Cards</Text>
    </TouchableOpacity>
  );
}

const getDecksButtonStyle = StyleSheet.create({
  container: {
    position: "absolute",
    bottom: 70,
    width: 300,
    height: 70,
    backgroundColor: "#007bff",
    zIndex: 1,
    borderRadius: 35,
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontWeight: "bold",
    fontSize: 30,
    color: "white",
  },
});
