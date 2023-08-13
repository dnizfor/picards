import React, { useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import DefaultDeckCard from "../components/getCardScreen/DefaultDeckCard";
import { StyleSheet, FlatList, TextInput, Text } from "react-native";
import DeckList from "../assets/jsons/deck_list.json";
import searchDecksByName from "../utils/searchDecksByName";
import GetAllDecksButton from "../components/getCardScreen/GetAllDecksButton";
import {
  getSetDataById,
  getWordsBySetId,
  getVideosByWordId,
} from "../utils/jsonFilter";
import { insertData } from "../utils/dbController";

export default function GetCardScreen({ navigation }) {
  const [text, setText] = useState("");
  const [data, setData] = useState([]);
  const [choosedList, setChoosedList] = useState([]);
  const onPressToCard = (id) => {
    if (choosedList.includes(id)) {
      const newChoosedList = choosedList.filter((item) => item !== id);
      setChoosedList(newChoosedList);
    } else {
      setChoosedList((prev) => [...prev, id]);
    }
  };

  const renderItems = ({ item }) => (
    <DefaultDeckCard
      title={item.deck_name}
      subtitle={"card-deck"}
      onPress={() => onPressToCard(item.deck_id)}
      isSelected={choosedList.includes(item.deck_id)}
    />
  );
  useEffect(() => {
    setData(DeckList);
  }, []);
  useEffect(() => {
    const newData = searchDecksByName(text, DeckList);
    setData(newData);
  }, [text]);
  const getCards = async () => {
    for (let index = 0; index < choosedList.length; index++) {
      try {
        const choosed_set_id = choosedList[index];
        const dataOfSet = getSetDataById(choosed_set_id);

        const DeckListResult = await insertData("deck_list", dataOfSet);
        const newSetId = DeckListResult.set_id;

        const allVocabularyOfSet = getWordsBySetId(choosed_set_id);

        for (let index = 0; index < allVocabularyOfSet.length; index++) {
          const wordData = allVocabularyOfSet[index];
          const vocabularyListResult = await insertData("vocabulary_list", {
            ...wordData,
            set_id: newSetId,
          });
          const newWordId = vocabularyListResult.word_id;

          const allVideosOfWord = getVideosByWordId();

          for (let index = 0; index < allVideosOfWord.length; index++) {
            const videoData = allVideosOfWord[index];
            const vocabularyListResult = await insertData("video_list", {
              ...videoData,
              word_id: newWordId,
            });
          }
        }
      } catch (e) {
        console.log("err", e);
      }
    }

    navigation.navigate("DeckListScreen");
  };

  return (
    <SafeAreaView style={setCardScreenStyle.container}>
      <TextInput
        style={setCardScreenStyle.inputContainer}
        onChangeText={setText}
        value={text}
        placeholder="Find Deck"
      />
      {choosedList.length > 0 && <GetAllDecksButton onPress={getCards} />}

      <FlatList
        data={data}
        renderItem={renderItems}
        showsVerticalScrollIndicator={false}
        extraData={choosedList}
      />
    </SafeAreaView>
  );
}

const setCardScreenStyle = StyleSheet.create({
  container: {
    alignItems: "center",
    paddingVertical: 20,
    position: "relative",
  },
  inputContainer: {
    backgroundColor: "white",
    width: 300,
    height: 50,
    borderRadius: 25,
    textAlign: "center",
    fontWeight: "bold",
    fontSize: 15,
    borderBottomColor: "black",
    borderBottomWidth: 1,
  },
});
