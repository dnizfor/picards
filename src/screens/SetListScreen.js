import { View, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import PlusButton from "../components/global/PlusButton";

export default function SetListScreen() {
  return (
    <SafeAreaView style={setListCreenContainer.container}>
      <View style={setListCreenContainer.plusButtonContainer}>
        <PlusButton />
      </View>
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
