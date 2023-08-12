import React from "react";
import FeedSreen from "../screens/FeedSreen";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { View } from "react-native";
import FeedDraverContent from "../components/FeedDraverContent";

const Drawer = createDrawerNavigator();

export default function FeedDrawer() {
  return (
    <Drawer.Navigator
      screenOptions={{
        headerShown: false,
      }}
      drawerContent={FeedDraverContent}
    >
      <Drawer.Screen name="FeedScreen" component={FeedSreen} />
    </Drawer.Navigator>
  );
}
