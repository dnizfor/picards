import { View, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";
import ChooseMenu from "../components/SetListScreen/ChooseMenu";
import { useState } from "react";

export default function SetListScreen() {
  const [isOpen, setIsOpen] = useState(false);
  const ChooseCardsOptions = [
    { title: "Add Card", onPress: () => console.log("okk") },
    { title: "Get Card", onPress: () => console.log("okk") },
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
