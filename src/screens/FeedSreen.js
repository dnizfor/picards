import { View, Text, FlatList, StyleSheet, Dimensions } from "react-native";
import React from "react";
import { SafeAreaView } from "react-native-safe-area-context";

export default function FeedSreen() {
  const array = [1, 2, 3];
  const renderItem = ({ item, index }) => {
    return (
      <View style={feedScreenStyle.postContainer}>
        <Text>{item}</Text>
      </View>
    );
  };
  return (
    <SafeAreaView>
      <FlatList
        renderItem={renderItem}
        data={array}
        pagingEnabled={true}
        keyExtractor={(item) => item}
        decelerationRate={"normal"}
      />
    </SafeAreaView>
  );
}
const feedScreenStyle = StyleSheet.create({
  postContainer: {
    flex: 1,
    height: Dimensions.get("screen").height - 160,
    backgroundColor: "yellow",
  },
});
