import React, { useEffect } from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { Ionicons } from "@expo/vector-icons";
import SettingsScreen from "../screens/SettingsScreen";
import DeckListStack from "./DeckListStack";
import FeedDrawer from "./FeedDrawer";
import { useSQLiteContext } from "expo-sqlite";

const Tab = createBottomTabNavigator();

export default function TabNavigator() {
  const screenOptions = ({ route }) => ({
    tabBarIcon: ({ focused, color, size }) => {
      let iconName;

      if (route.name === "DeckListStack") {
        iconName = focused ? "cards" : "cards-outline";
        return (
          <MaterialCommunityIcons name={iconName} size={size} color={color} />
        );
      } else if (route.name === "SettingsScreen") {
        iconName = focused ? "settings-sharp" : "settings-outline";
        return <Ionicons name={iconName} size={size} color={color} />;
      } else if (route.name === "FeedDrawer") {
        iconName = focused ? "compass" : "compass-outline";
        return <Ionicons name={iconName} size={size} color={color} />;
      }

      // You can return any component that you like here!
    },
    tabBarActiveTintColor: "#007bff",
    tabBarInactiveTintColor: "gray",
    headerShown: false,
    tabBarShowLabel: false,
    tabBarHideOnKeyboard: true,
  });
  const db = useSQLiteContext();

useEffect(()=>{
  async function createDatabase() {
    try{
      const result = await db.runAsync(
        `CREATE TABLE IF NOT EXISTS vocabularyData (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          deck TEXT,
          word TEXT,
          mean TEXT,
          video TEXT,
          title TEXT,
          level TEXT
        );`
      )
    }
    catch(e){
      console.log(e);
    }
  

  }
  createDatabase();
},[])
  return (
    <NavigationContainer>
      <Tab.Navigator
        screenOptions={screenOptions}
        initialRouteName="FeedDrawer"
      >
        <Tab.Screen name="DeckListStack" component={DeckListStack} />
        <Tab.Screen name="FeedDrawer" component={FeedDrawer} />
        <Tab.Screen name="SettingsScreen" component={SettingsScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}
