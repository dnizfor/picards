import { Text, TouchableOpacity } from "react-native";
import React from "react";

const SurveyItem = ({ item, onPress, backgroundColor, textColor }) => (
  <TouchableOpacity
    onPress={onPress}
    style={[surveyItenStyles.item, { backgroundColor }]}
  >
    <Text style={[surveyItenStyles.title, { color: textColor }]}>
      {item.title}
    </Text>
  </TouchableOpacity>
);

const surveyItenStyles = StyleSheet.create({
  item: {
    padding: 20,
    marginVertical: 8,
    marginHorizontal: 16,
  },
  title: {
    fontSize: 32,
  },
});
export default SurveyItem;
