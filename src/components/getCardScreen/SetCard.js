import { Text } from "react-native";
import React from "react";
import { StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native";

export default function SetCard({ onPress, title, count, isSelected }) {
  return (
    <TouchableOpacity
      onPress={onPress}
      style={
        isSelected ? setCardStyle.selectedContainer : setCardStyle.container
      }
    >
      <Text
        style={isSelected ? setCardStyle.selectedTitle : setCardStyle.title}
      >
        {title}
      </Text>
      <Text
        style={isSelected ? setCardStyle.selectedCount : setCardStyle.count}
      >
        {count}
      </Text>
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
  selectedContainer: {
    width: 300,
    height: 100,
    borderRadius: 20,
    marginVertical: 10,
    justifyContent: "center",
    paddingHorizontal: 20,
    backgroundColor: "green",
  },
  title: { fontSize: 25, fontWeight: "bold" },
  selectedTitle: { fontSize: 25, fontWeight: "bold", color: "white" },
  count: { fontSize: 15, fontWeight: "bold", color: "grey" },
  selectedCount: { fontSize: 15, fontWeight: "bold", color: "white" },
});
