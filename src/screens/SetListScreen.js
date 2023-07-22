import { View, StyleSheet, TextInput } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/SetListScreen/ChooseMenu";
import { useState } from "react";
import SetCard from "../components/getCardScreen/SetCard";
import { FlatList } from "react-native";

export default function SetListScreen({ navigation }) {
  const [isOpen, setIsOpen] = useState(false);
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

  const renderItems = ({ item }) => (
    <SetCard title={item.set_name} count={"18-word"} />
  );
  const data = [{ set_name: "set_name", set_id: 1 }];
  return (
    <SafeAreaView style={setListCreenContainer.container}>
      <View style={setListCreenContainer.plusButtonContainer}>
        <PlusButton onPress={() => setIsOpen(true)} />
      </View>
      <TextInput
        style={setListCreenContainer.inputContainer}
        // onChangeText={onChangeText}
        // value={text}
        placeholder="Find Set"
      />
      <FlatList
        data={data}
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
    backgroundColor: "yellow",
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
  },
});
