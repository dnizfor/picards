import { Text } from "react-native";
import React from "react";
import { StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native";

export default function DefaultDeckCard({ onPress, title, count, isSelected }) {
  return (
    <TouchableOpacity
      onPress={onPress}
      style={
        isSelected
          ? defaultDeckCardStyle.selectedContainer
          : defaultDeckCardStyle.container
      }
    >
      <Text
        style={
          isSelected
            ? defaultDeckCardStyle.selectedTitle
            : defaultDeckCardStyle.title
        }
      >
        {title}
      </Text>
      <Text
        style={
          isSelected
            ? defaultDeckCardStyle.selectedCount
            : defaultDeckCardStyle.count
        }
      >
        {count}
      </Text>
    </TouchableOpacity>
  );
}

const defaultDeckCardStyle = StyleSheet.create({
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
    backgroundColor: "#14A44D",
  },
  title: { fontSize: 25, fontWeight: "bold" },
  selectedTitle: { fontSize: 25, fontWeight: "bold", color: "white" },
  count: { fontSize: 15, fontWeight: "bold", color: "grey" },
  selectedCount: { fontSize: 15, fontWeight: "bold", color: "white" },
});
