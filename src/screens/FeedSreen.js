import { View, Text, FlatList, StyleSheet, Dimensions } from "react-native";
import React, { useCallback, useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import FlashCard from "../components/feedScreen/FlashCard";
import VidoCard from "../components/feedScreen/VidoCard";
import SurveyCard from "../components/feedScreen/surveyCard/SurveyCard";
import { useBottomTabBarHeight } from '@react-navigation/bottom-tabs';
import { useFocusEffect } from "@react-navigation/native";
import { useSQLiteContext } from "expo-sqlite";
import { FlashList } from "@shopify/flash-list";
export default function FeedSreen({ mode, choosedList, setDeckList }) {
  const tabBarHeight = useBottomTabBarHeight();
  const [vocabularyData, setVocabularyData] = useState([])
  const [visibleItemId, setVisibleItemId] = useState("")

  const onViewableItemsChanged = ({ viewableItems }) => {
    setVisibleItemId(viewableItems[0]?.item.id)

  };
  const db = useSQLiteContext()
  useEffect(() => {
    db.getAllAsync(
      `SELECT DISTINCT deck FROM vocabularyData ;`
    )
      .then((result) => {
        console.log("Seçilen veriler:", result);
        console.log("feed screen açıldı ", result);
        setDeckList(result);
      })
      .catch((error) => {
        console.log("Veri seçme hatası:", error);
      });
  }, [])

  useFocusEffect(
    useCallback(() => {
      // Burada yapmak istediğiniz işlemleri gerçekleştirin
      console.log(choosedList);
      if (choosedList.length === 0) {
        return
      }

      // hata veriyor bu sebeple kaldırdık
      // const queryConditions = choosedList
      //   .map(item =>
      //     `deck='${item.deck}'`

      //   )
      //   .join(' OR ');
      // let query = `SELECT * FROM vocabularyData WHERE ${queryConditions} `;
      let query = `SELECT * FROM vocabularyData `;

      db.getAllAsync(
        query
      )
        .then((result) => {
          console.log("veri seçildi feed screen");
          result.filter(data => choosedList === (data.deck))
          setVocabularyData(result);
        })
        .catch((error) => {
          console.log("Veri seçme hatası:", error, choosedList,);
        });



      return () => { };
    }, [choosedList])
  );

  const renderItem = ({ item, index }) => {

    return (
      <View style={{ ...feedScreenStyle.postContainer, height: Dimensions.get("window").height - tabBarHeight, }}>
        {mode == "FlashCard" && <FlashCard word={item.word} mean={item.mean} />}
        {mode == "VidoCard" && <VidoCard isVisible={visibleItemId === item.id} word={item.word} mean={item.mean} videoUrl={item.video} />}

        {mode != "FlashCard" && mode != "VidoCard" && <SurveyCard isVisible={visibleItemId === item?.id} mean={item?.mean} videoUrl={item?.video} />}
      </View>
    );
  };
  return (
    <SafeAreaView style={{flex:1}}>
       <FlashList
        renderItem={renderItem}
        data={vocabularyData}
        pagingEnabled={true}
        estimatedItemSize={200}
        decelerationRate={"normal"}
        viewabilityConfig={{
          viewAreaCoveragePercentThreshold: 50,
        }}
        onViewableItemsChanged={onViewableItemsChanged}
        initialNumToRender={4}
      />

     
    </SafeAreaView>
  );
}
const feedScreenStyle = StyleSheet.create({
  postContainer: {
    flex: 1,
  },
});
