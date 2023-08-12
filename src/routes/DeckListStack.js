import React from "react";
import DeckListScreen from "../screens/DeckListScreen";
import AddDeckScreen from "../screens/AddDeckScreen";
import GetCardScreen from "../screens/GetCardScreen";
import { createStackNavigator } from "@react-navigation/stack";

const Stack = createStackNavigator();

export default function DeckListStack() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
      }}
    >
      <Stack.Screen name="DeckListScreen" component={DeckListScreen} />
      <Stack.Screen name="AddCardScreen" component={AddDeckScreen} />
      <Stack.Screen name="GetCardScreen" component={GetCardScreen} />
    </Stack.Navigator>
  );
}
