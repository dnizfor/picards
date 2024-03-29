import React, { useState } from "react";
import FeedSreen from "../screens/FeedSreen";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { View } from "react-native";
import FeedDraverContent from "../components/FeedDraverContent";

const Drawer = createDrawerNavigator();

export default function FeedDrawer() {
  const [mode, setMode] = useState("VidoCard");

  return (
    <Drawer.Navigator
      screenOptions={{
        headerShown: false,
      }}
      drawerContent={() => <FeedDraverContent setMode={setMode} />}
    >
      <Drawer.Screen name="FeedScreen">
        {(props) => <FeedSreen {...props} mode={mode} />}
      </Drawer.Screen>
    </Drawer.Navigator>
  );
}
