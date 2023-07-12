import { View, Text, StyleSheet } from "react-native";
import React from "react";

export default function GetAllSetButton() {
  return (
    <View style={getSetButtonStyle.container}>
      <Text style={getSetButtonStyle.title}>Get Cards</Text>
    </View>
  );
}

const getSetButtonStyle = StyleSheet.create({
  container: {
    position: "absolute",
    bottom: 70,
    width: 300,
    height: 70,
    backgroundColor: "blue",
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
