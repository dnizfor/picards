import { Text, StyleSheet } from "react-native";
import React, { useCallback, useEffect, useState } from "react";
import { DrawerContentScrollView, DrawerItem } from "@react-navigation/drawer";
import { useSQLiteContext } from "expo-sqlite";
import { useFocusEffect } from "@react-navigation/native";

export default function FeedDraverContent(props) {
  const modList = ["VidoCard", "FlashCard", "Translate"];
  const [modIndex, setModIndex] = useState(0);
  const [deckList, setDeckList] = useState([]);
  const setMode = props.setMode;
 
  db = useSQLiteContext()
  useFocusEffect(
    useCallback(() => {
      // Burada yapmak istediğiniz işlemleri gerçekleştirin
      console.log("Sayfa görüntülendi, useEffect gibi işlemler yapılabilir");

      db.getAllAsync(
        `SELECT DISTINCT deck FROM vocabularyData ;`
      )
        .then((result) => {
          console.log("Seçilen veriler:", result);
          setDeckList(result);
        })
        .catch((error) => {
          console.log("Veri seçme hatası:", error);
        });

      return () => {};
    }, [])
  );
  const [choosedList, setChoosedList] = useState([]);
  const onChoose = (deckName) => {
    if (choosedList.includes(deckName)) {
      const newChoosedList = choosedList.filter((item) => item !== deckName);
      setChoosedList(newChoosedList);
    } else {
      setChoosedList((prev) => [...prev, deckName]);
    }
  };
  return (
    <DrawerContentScrollView {...props}>
      <Text style={feedDrawerStyles.title}>Mode</Text>
      {modList.map((item, index) => (
        <DrawerItem
          label={item}
          onPress={() => {
            setModIndex(index);
            setMode(item);
          }}
          focused={modList[modIndex] === item}
          key={index}
        />
      ))}

      <Text style={feedDrawerStyles.title}>Decks</Text>
      {deckList.map((item, index) => (
        <DrawerItem
          label={item.deck}
          onPress={() => onChoose(item)}
          focused={choosedList.includes(item)}
          key={index}
        />
      ))}
    </DrawerContentScrollView>
  );
}
const feedDrawerStyles = StyleSheet.create({
  title: {
    fontWeight: "bold",
    marginLeft: 10,
    marginTop: 10,
  },
});
