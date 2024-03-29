import { View, Text, FlatList, StyleSheet, Dimensions } from "react-native";
import React, { useEffect } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import FlashCard from "../components/feedScreen/FlashCard";
import VidoCard from "../components/feedScreen/VidoCard";
import SurveyCard from "../components/feedScreen/surveyCard/SurveyCard";

export default function FeedSreen({ mode }) {
  const array = [1, 2, 3];

  const onViewableItemsChanged = ({ viewableItems }) => {
    console.log("***********Visible items are", viewableItems[0].index);
  };
  useEffect(() => {
    console.log("'''''''''''''''''22mode", mode == "Flashcard");
  }, [mode]);

  const renderItem = ({ item, index }) => {
    return (
      <View style={feedScreenStyle.postContainer}>
        {mode == "FlashCard" && <FlashCard word={item} mean={"itemitem"} />}
        {mode == "VidoCard" && <VidoCard />}

        {mode != "FlashCard" && mode != "VidoCard" && <SurveyCard />}
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
        viewabilityConfig={{
          viewAreaCoveragePercentThreshold: 50,
        }}
        onViewableItemsChanged={onViewableItemsChanged}
      />
    </SafeAreaView>
  );
}
const feedScreenStyle = StyleSheet.create({
  postContainer: {
    flex: 1,
    height: Dimensions.get("screen").height - 180,
  },
});
