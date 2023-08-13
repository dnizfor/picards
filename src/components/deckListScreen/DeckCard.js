import {
  View,
  Animated,
  TouchableOpacity,
  StyleSheet,
  Text,
} from "react-native";
import React from "react";
import { Swipeable } from "react-native-gesture-handler";
import { FontAwesome5 } from "@expo/vector-icons";

export default function DeckCard({ onPress, title, count }) {
  const renderRightActions = (progress, dragX) => {
    const scale = dragX.interpolate({
      inputRange: [-100, 0],
      outputRange: [1, 0],
      extrapolate: "clamp",
    });

    return (
      <TouchableOpacity
        onPress={() => console.log("delete")}
        style={deckCardStyle.swipeableContainer}
      >
        <View style={deckCardStyle.deleteButton}>
          <Animated.Text
            style={[deckCardStyle.deleteButtonText, { transform: [{ scale }] }]}
          >
            <FontAwesome5 name="trash" size={40} color="white" />
          </Animated.Text>
        </View>
      </TouchableOpacity>
    );
  };

  return (
    <Swipeable renderRightActions={renderRightActions}>
      <TouchableOpacity onPress={onPress} style={deckCardStyle.container}>
        <Text style={deckCardStyle.title}>{title}</Text>
        <Text style={deckCardStyle.count}>{count}</Text>
      </TouchableOpacity>
    </Swipeable>
  );
}

const deckCardStyle = StyleSheet.create({
  container: {
    width: 300,
    height: 100,
    borderRadius: 20,
    backgroundColor: "white",
    marginVertical: 10,
    justifyContent: "center",
    paddingHorizontal: 20,
  },
  swipeableContainer: {
    justifyContent: "center",
  },
  title: { fontSize: 25, fontWeight: "bold" },
  count: { fontSize: 15, fontWeight: "bold", color: "grey" },
  deleteButton: {
    backgroundColor: "red",
    justifyContent: "center",
    alignItems: "center",
    width: 75,
    borderRadius: 10,
    height: 100,
  },
  deleteButtonText: {
    color: "white",
    fontWeight: "bold",
    fontSize: 90,
  },
});
