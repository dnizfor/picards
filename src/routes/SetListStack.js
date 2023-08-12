import React from "react";
import SetListScreen from "../screens/SetListScreen";
import AddSetScreen from "../screens/AddSetScreen";
import GetCardScreen from "../screens/GetCardScreen";
import { createStackNavigator } from "@react-navigation/stack";

const Stack = createStackNavigator();

export default function SetListStack() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
      }}
    >
      <Stack.Screen name="Home" component={SetListScreen} />
      <Stack.Screen name="AddCardScreen" component={AddSetScreen} />
      <Stack.Screen name="GetCardScreen" component={GetCardScreen} />
    </Stack.Navigator>
  );
}
