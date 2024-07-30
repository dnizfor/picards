import { Text, StyleSheet } from "react-native";
import React, { useCallback, useEffect, useState } from "react";
import { DrawerContentScrollView, DrawerItem } from "@react-navigation/drawer";

export default function FeedDraverContent(props) {
  const modList = ["VidoCard", "FlashCard", "Translate"];
  const [modIndex, setModIndex] = useState(0);
  const setMode = props.setMode;
  const setChoosedList=props.setChoosedList
  const choosedList=props.choosedList
  const deckList= props.deckList
 

  const onChoose = (deckName) => {
    setChoosedList((prev) => prev === deckName ? "" : deckName)
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
          focused={choosedList === item}
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
