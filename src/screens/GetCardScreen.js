import React, { useEffect, useState } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import SetCard from "../components/getCardScreen/SetCard";
import { StyleSheet, FlatList, TextInput } from "react-native";
import SetList from "../assets/jsons/set_list.json";
import searchSetsByName from "../utils/searchSetsByName";

export default function GetCardScreen() {
  const renderItems = ({ item }) => (
    <SetCard title={item.set_name} count={"18-word"} />
  );
  const [text, onChangeText] = useState("");
  const [data, setData] = useState([]);

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
      <FlatList
        data={data}
        renderItem={renderItems}
        showsVerticalScrollIndicator={false}
      />
    </SafeAreaView>
  );
}

const setCardScreenStyle = StyleSheet.create({
  container: {
    alignItems: "center",
    paddingVertical: 20,
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
