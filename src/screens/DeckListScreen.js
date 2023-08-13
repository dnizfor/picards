import { View, StyleSheet, TextInput } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/deckListScreen/ChooseMenu";
import { useEffect, useState } from "react";
import { FlatList } from "react-native";
import DeckCard from "../components/deckListScreen/DeckCard";
import { selectData } from "../utils/dbController";
import searchDecksByName from "../utils/searchDecksByName";
export default function DeckListScreen({ navigation }) {
  const [isOpen, setIsOpen] = useState(false);
  const [data, setData] = useState([]);
  const [text, setText] = useState("");
  const [filteredData, setFilteredData] = useState([]);
  useEffect(() => {
    const columnsToSelect = ["id", "deck_name", "url"]; // İsteğe bağlı olarak seçilecek sütunları belirtin
    const selectionCondition = "1"; // Tüm verileri almak için boş bir koşul kullanabilirsiniz

    selectData("deck_list", columnsToSelect, selectionCondition)
      .then((result) => {
        // Veriler başarıyla seçildi, işlemler burada yapılabilir
        console.log("Seçilen veriler:", result);
        setData(result.rows._array);
        setFilteredData(result.rows._array);
      })
      .catch((error) => {
        // Hata durumunda işlemler burada yapılabilir
        console.log("Veri seçme hatası:", error);
      });
  }, []);

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

  const renderItems = ({ item }) => {
    return <DeckCard title={item.deck_name} count={`${count}-card`} />;
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
