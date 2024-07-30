import React, { useState } from "react";
import FeedSreen from "../screens/FeedSreen";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { View } from "react-native";
import FeedDraverContent from "../components/FeedDraverContent";

const Drawer = createDrawerNavigator();

export default function FeedDrawer() {
  const [mode, setMode] = useState("VidoCard");
  const [choosedList, setChoosedList] = useState("");
  const [deckList, setDeckList] = useState([]);

  

  return (
    <Drawer.Navigator
      screenOptions={{
        headerShown: false,
      }}
      drawerContent={() => <FeedDraverContent deckList={deckList} setMode={setMode}  choosedList={choosedList} setChoosedList={setChoosedList} />}
    >
      <Drawer.Screen name="FeedScreen">
        {(props) => <FeedSreen {...props} mode={mode} choosedList={choosedList}  setDeckList={setDeckList}/>}
      </Drawer.Screen>
    </Drawer.Navigator>
  );
}
