import { NavigationContainer } from "@react-navigation/native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import SetsScreen from "./src/screens/SetsScreen";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import { Ionicons } from "@expo/vector-icons";
import { SafeAreaProvider } from "react-native-safe-area-context";

const Tab = createBottomTabNavigator();

export default function App() {
  const screenOptions = ({ route }) => ({
    tabBarIcon: ({ focused, color, size }) => {
      let iconName;

      if (route.name === "SetsScreen") {
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
          <Tab.Screen name="SetsScreen" component={SetsScreen} />
          <Tab.Screen name="FeedSreen" component={SetsScreen} />
          <Tab.Screen name="SettingsScreen" component={SetsScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
