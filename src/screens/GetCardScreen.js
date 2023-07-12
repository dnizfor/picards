import React, { useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import SetCard from "../components/getCardScreen/SetCard";
import { StyleSheet, FlatList, TextInput, Text } from "react-native";
import SetList from "../assets/jsons/set_list.json";
import searchSetsByName from "../utils/searchSetsByName";
import GetAllSetButton from "../components/getCardScreen/GetAllSetButton";

export default function GetCardScreen() {
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

  return (
    <SafeAreaView style={setCardScreenStyle.container}>
      <TextInput
        style={setCardScreenStyle.inputContainer}
        onChangeText={onChangeText}
        value={text}
        placeholder="Find Set"
      />
      <GetAllSetButton />

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
