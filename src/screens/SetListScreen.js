import { View, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/SetListScreen/ChooseMenu";
import { useState } from "react";

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
  return (
    <SafeAreaView style={setListCreenContainer.container}>
      <View style={setListCreenContainer.plusButtonContainer}>
        <PlusButton onPress={() => setIsOpen(true)} />
      </View>
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
  },
  plusButtonContainer: {
    position: "absolute",
    bottom: 20,
    right: 20,
  },
});
