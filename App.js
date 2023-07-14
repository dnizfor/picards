import { NavigationContainer } from "@react-navigation/native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import SetListScreen from "./src/screens/SetListScreen.js";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { Ionicons } from "@expo/vector-icons";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { createStackNavigator } from "@react-navigation/stack";
import GetCardScreen from "./src/screens/GetCardScreen.js";
import { useEffect } from "react";
import { initializeDatabase } from "./src/utils/dbController.js";
import AddSetScreen from "./src/screens/AddSetScreen.js";

const Stack = createStackNavigator();

function SetListStack() {
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
const Tab = createBottomTabNavigator();

export default function App() {
  useEffect(() => {
    initializeDatabase();
  }, []);
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
  });

  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <Tab.Navigator screenOptions={screenOptions}>
          <Tab.Screen name="SetListScreen" component={SetListStack} />
          <Tab.Screen name="FeedSreen" component={SetListScreen} />
          <Tab.Screen name="SettingsScreen" component={SetListScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
