import {
  View,
  TextInput,
  Animated,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import React from "react";
import { Swipeable } from "react-native-gesture-handler";
import { FontAwesome5 } from "@expo/vector-icons";
export default function NewCard() {
  const renderRightActions = (progress, dragX) => {
    const scale = dragX.interpolate({
      inputRange: [-100, 0],
      outputRange: [1, 0],
      extrapolate: "clamp",
    });

    return (
      <TouchableOpacity onPress={() => console.log("delete")}>
        <View style={newCardStyle.deleteButton}>
          <Animated.Text
            style={[newCardStyle.deleteButtonText, { transform: [{ scale }] }]}
          >
            <FontAwesome5 name="trash" size={40} color="white" />
          </Animated.Text>
        </View>
      </TouchableOpacity>
    );
  };
  return (
    <Swipeable renderRightActions={renderRightActions}>
      <View style={newCardStyle.container}>
        <TextInput style={newCardStyle.textInputContainer} placeholder="Word" />
        <TextInput style={newCardStyle.textInputContainer} placeholder="Mean" />
      </View>
    </Swipeable>
  );
}
const newCardStyle = StyleSheet.create({
  container: {
    width: 300,
    backgroundColor: "white",
    height: 120,
    borderRadius: 20,
    padding: 10,
    justifyContent: "space-around",
  },
  textInputContainer: {
    borderBottomColor: "black",
    borderBottomWidth: 1,
    fontSize: 15,
    paddingLeft: 5,
    paddingHorizontal: 20,
  },

  deleteButton: {
    backgroundColor: "red",
    justifyContent: "center",
    alignItems: "center",
    width: 75,
    borderRadius: 10,
    height: "100%",
  },
  deleteButtonText: {
    color: "white",
    fontWeight: "bold",
    fontSize: 90,
  },
});
