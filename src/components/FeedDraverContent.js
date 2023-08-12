import { Text, StyleSheet } from "react-native";
import React, { useState } from "react";
import { DrawerContentScrollView, DrawerItem } from "@react-navigation/drawer";

export default function FeedDraverContent(props) {
  const modList = ["Learn", "Flashcard", "Space", "Listening"];
  const [modIndex, setModIndex] = useState(0);

  const deckList = [
    "set-12",
    "1",
    "2",
    "4",
    "set-12",
    "5",
    "Spa6ce",
    "7",
    "6-12",
    "Fla2shcard",
    "Spac1e",
    "List3ening",
  ];
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
          onPress={() => setModIndex(index)}
          focused={modList[modIndex] === item}
          key={index}
        />
      ))}

      <Text style={feedDrawerStyles.title}>Decks</Text>
      {deckList.map((item, index) => (
        <DrawerItem
          label={item}
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
