import React, { useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import SetCard from "../components/getCardScreen/SetCard";
import { StyleSheet, FlatList, TextInput, Text } from "react-native";
import SetList from "../assets/jsons/set_list.json";
import searchSetsByName from "../utils/searchSetsByName";
import GetAllSetButton from "../components/getCardScreen/GetAllSetButton";
import {
  getSetDataById,
  getWordsBySetId,
  getVideosByWordId,
} from "../utils/jsonFilter";
import { insertData } from "../utils/dbController";

export default function GetCardScreen({ navigation }) {
  const [text, onChangeText] = useState("");
  const [data, setData] = useState([]);
  const [choosedList, setChoosedList] = useState([]);
  const onPressToCard = (id) => {
    let newChoosedList = choosedList;
    if (choosedList.includes(id)) {
      const index = newChoosedList.indexOf(id);
      newChoosedList.splice(index, 1);
      setChoosedList(newChoosedList);
    } else {
      newChoosedList.push(id);
      setChoosedList(newChoosedList);
    }
  };

  const renderItems = ({ item }) => (
    <SetCard
      title={item.set_name}
      count={"18-word"}
      onPress={() => onPressToCard(item.set_id)}
      isSelected={choosedList.includes(item.set_id)}
    />
  );
  useEffect(() => {
    setData(SetList);
  }, []);
  useEffect(() => {
    const newData = searchSetsByName(text, SetList);
    setData(newData);
  }, [text]);
  const getCards = async () => {
    for (let index = 0; index < choosedList.length; index++) {
      try {
        const choosed_set_id = choosedList[index];
        const dataOfSet = getSetDataById(choosed_set_id);

        const setListResult = await insertData("set_list", dataOfSet);
        const newSetId = setListResult.set_id;

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

    navigation.navigate("Home");
  };

  return (
    <SafeAreaView style={setCardScreenStyle.container}>
      <TextInput
        style={setCardScreenStyle.inputContainer}
        onChangeText={onChangeText}
        value={text}
        placeholder="Find Set"
      />
      <GetAllSetButton onPress={getCards} />

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
