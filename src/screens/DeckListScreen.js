import { View, StyleSheet, TextInput } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/deckListScreen/ChooseMenu";
import { useEffect, useState, useCallback } from "react";
import { FlatList } from "react-native";
import DeckCard from "../components/deckListScreen/DeckCard";
import searchDecksByName from "../utils/searchDecksByName";
import { useFocusEffect } from "@react-navigation/native";
import { useSQLiteContext } from "expo-sqlite";

export default function DeckListScreen({ navigation }) {
  const [isOpen, setIsOpen] = useState(false);
  const [data, setData] = useState([]);
  const [text, setText] = useState("");
  const [filteredData, setFilteredData] = useState([]);
  const [updateData, setUpdateData] = useState(false);
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
          setData(result);
          setFilteredData(result);
        })
        .catch((error) => {
          console.log("Veri seçme hatası:", error);
        });

      return () => {};
    }, [updateData])
  );

  useEffect(() => {
    const newData = searchDecksByName(text, data);
    setFilteredData(newData);
  }, [text]);

  const ChooseCardsOptions = [
    {
      title: "Add Card",
      onPress: () => {
        setIsOpen(false);
        navigation.navigate("AddCardScreen");
      },
    },
    {
      title: "Get Card",
      onPress: () => {
        setIsOpen(false);
        navigation.navigate("GetCardScreen");
      },
    },
  ];
  const onDelete = async (deckToDelete, callback) => {
    try{
      await db.runAsync('DELETE FROM vocabularyData WHERE deck = $value', { $value: deckToDelete })
      callback()

    }  catch(e){
      console.log(e);
    }


  };

  const renderItems = ({ item }) => {
    return (
      <DeckCard
        title={item.deck}
        subtitle={"card-deck"}
        onDelete={() => onDelete(item.deck, () => setUpdateData((prev) => !prev))}
      />
    );
  };

  return (
    <SafeAreaView style={setListCreenContainer.container}>
      <View style={setListCreenContainer.plusButtonContainer}>
        <PlusButton onPress={() => setIsOpen(true)} />
      </View>
      <TextInput
        style={setListCreenContainer.inputContainer}
        onChangeText={setText}
        value={text}
        placeholder="Find Deck"
      />
      <FlatList
        data={filteredData}
        renderItem={renderItems}
        showsVerticalScrollIndicator={false}
      />
      {isOpen && (
        <ChooseMenu
          onPressToBackground={() => setIsOpen(false)}
          ChooseCardsOptions={ChooseCardsOptions}
        />
      )}
    </SafeAreaView>
  );
}

const setListCreenContainer = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#EFEFEF",
    position: "relative",
    alignItems: "center",
  },
  plusButtonContainer: {
    position: "absolute",
    bottom: 20,
    right: 20,
    zIndex: 1,
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
    marginTop: 15,
  },
});
