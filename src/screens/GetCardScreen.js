import React, { useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import DefaultDeckCard from "../components/getCardScreen/DefaultDeckCard";
import { StyleSheet, FlatList, TextInput, Text } from "react-native";
import DeckList from "../assets/jsons/data.json";
import searchDecksByName from "../utils/searchDecksByName";
import GetAllDecksButton from "../components/getCardScreen/GetAllDecksButton";
import {
  getWordsByDeckName,
} from "../utils/jsonFilter";
import { useSQLiteContext } from "expo-sqlite";

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
  const db = useSQLiteContext();
  const renderItems = ({ item }) => (
    <DefaultDeckCard
      title={item.deck}
      subtitle={"card-deck"}
      onPress={() => onPressToCard(item.deck)}
      isSelected={choosedList.includes(item.deck)}
    />
  );
  useEffect(() => {
    const uniqueDeckObjects = [...new Map(DeckList.map(item => [item.deck, item])).values()]
    setData(uniqueDeckObjects);
  }, []);
  useEffect(() => {
    const uniqueDeckObjects = [...new Map(DeckList.map(item => [item.deck, item])).values()]
    const newData = searchDecksByName(text, uniqueDeckObjects);
    setData(newData);
  }, [text]);
  const getCards =  () => {
    for (let index = 0; index < choosedList.length; index++) {
        const choosedDeckName = choosedList[index];
        const wordsOfDeck = getWordsByDeckName(choosedDeckName)

        wordsOfDeck.map((wordData)=>{
          wordData = {...wordData,level:"starter"}
            db.runAsync(
              `INSERT INTO ${"vocabularyData"} (${Object.keys(wordData).join(
              ", "
            )}) VALUES (${Object.keys(wordData).fill("?").join(", ")});`,
            Object.values(wordData),).then(()=>console.log("succesfull"))
            .catch((e)=>console.log("err",e))
        })

        
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
