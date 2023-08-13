import { TouchableOpacity, FlatList, StyleSheet } from "react-native";
import React from "react";
import ChooseCard from "./ChooseCard";

export default function ChooseMenu({
  onPressToBackground,
  ChooseCardsOptions,
}) {
  const renderItems = ({ item }) => (
    <ChooseCard title={item.title} onPress={item.onPress} />
  );

  return (
    <TouchableOpacity
      onPress={onPressToBackground}
      style={ChooseMenuStyle.container}
    >
      <FlatList
        contentContainerStyle={ChooseMenuStyle.flatListStyle}
        data={ChooseCardsOptions}
        renderItem={renderItems}
      />
    </TouchableOpacity>
  );
}
const ChooseMenuStyle = StyleSheet.create({
  container: {
    position: "absolute",
    top: 0,
    right: 0,
    left: 0,
    bottom: 0,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#EFEFEF",
    zIndex: 2,
  },
  flatListStyle: {
    height: "100%",
    justifyContent: "center",
    alignItems: "center",
  },
});
