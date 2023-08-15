import { View, StyleSheet, TextInput } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/deckListScreen/ChooseMenu";
import { useEffect, useState, useCallback } from "react";
import { FlatList } from "react-native";
import DeckCard from "../components/deckListScreen/DeckCard";
import { deleteData, selectData } from "../utils/dbController";
import searchDecksByName from "../utils/searchDecksByName";
import { useFocusEffect } from "@react-navigation/native";

export default function DeckListScreen({ navigation }) {
  const [isOpen, setIsOpen] = useState(false);
  const [data, setData] = useState([]);
  const [text, setText] = useState("");
  const [filteredData, setFilteredData] = useState([]);
  const [updateData, setUpdateData] = useState(false);

  useFocusEffect(
    useCallback(() => {
      // Burada yapmak istediğiniz işlemleri gerçekleştirin
      console.log("Sayfa görüntülendi, useEffect gibi işlemler yapılabilir");

      const columnsToSelect = ["id", "deck_name", "url"];
      const selectionCondition = "1";

      selectData("deck_list", columnsToSelect, selectionCondition)
        .then((result) => {
          console.log("Seçilen veriler:", result);
          setData(result.rows._array);
          setFilteredData(result.rows._array);
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
  const onDelete = async (deckIdToDelete, callback) => {
    try {
      // Veriyi deck_list tablosundan sil
      await deleteData("deck_list", `id = ${deckIdToDelete}`);

      // vocabulary_list tablosundan deck_id değeri deckIdToDelete olan verileri seç
      const vocabularyData = await selectData(
        "vocabulary_list",
        ["id", "word_id"],
        `deck_id = ${deckIdToDelete}`
      );
      for (const vocabulary of vocabularyData.rows._array) {
        const wordId = vocabulary.word_id;
        const vocabularyId = vocabulary.id;

        // video_list tablosundan word_id değeri wordId olan verileri sil
        await deleteData("video_list", `word_id = ${wordId}`);

        // vocabulary_list tablosundan veriyi sil
        await deleteData("vocabulary_list", `id = ${vocabularyId}`);
      }
      callback();
      console.log("İşlem başarıyla tamamlandı.");
    } catch (error) {
      console.error("Hata:", error);
    }
  };

  const renderItems = ({ item }) => {
    return (
      <DeckCard
        title={item.deck_name}
        subtitle={"card-deck"}
        onDelete={() => onDelete(item.id, () => setUpdateData((prev) => !prev))}
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
