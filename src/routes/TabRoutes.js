import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { Ionicons } from "@expo/vector-icons";
import SettingsScreen from "../screens/SettingsScreen";
import SetListStack from "./SetListStack";
import FeedDrawer from "./FeedDrawer";

const Tab = createBottomTabNavigator();

export default function TabRoutes() {
  const screenOptions = ({ route }) => ({
    tabBarIcon: ({ focused, color, size }) => {
      let iconName;

      if (route.name === "SetListScreen") {
        iconName = focused ? "cards" : "cards-outline";
        return (
          <MaterialCommunityIcons name={iconName} size={size} color={color} />
        );
      } else if (route.name === "SettingsScreen") {
        iconName = focused ? "settings-sharp" : "settings-outline";
        return <Ionicons name={iconName} size={size} color={color} />;
      } else if (route.name === "FeedSreen") {
        iconName = focused ? "compass" : "compass-outline";
        return <Ionicons name={iconName} size={size} color={color} />;
      }

      // You can return any component that you like here!
    },
    tabBarActiveTintColor: "blue",
    tabBarInactiveTintColor: "gray",
    headerShown: false,
    tabBarShowLabel: false,
    tabBarHideOnKeyboard: true,
  });

  return (
    <NavigationContainer>
      <Tab.Navigator screenOptions={screenOptions}>
        <Tab.Screen name="SetListScreen" component={SetListStack} />
        <Tab.Screen name="FeedSreen" component={FeedDrawer} />
        <Tab.Screen name="SettingsScreen" component={SettingsScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}
