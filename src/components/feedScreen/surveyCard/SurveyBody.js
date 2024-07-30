import React, { useState } from "react";
import { View } from "react-native";
import { FlatList, StatusBar, StyleSheet } from "react-native";
import SurveyItem from "./SurveyItem";
import keygen from "keygenerator"



const SurveyBody = ({options}) => {
  const [selected, setSelected] = useState();
  const renderItem = ({ item }) => {
    const backgroundColor = item?.option === selected ?  (item?.isAnswer ? "#14A44D" : "#dc3545" ): "white";
    const color = item?.option === selected ? "white" : "black";
    return (
      <SurveyItem
      title={item?.option}
        onPress={() => setSelected(item?.option)}
        backgroundColor={backgroundColor}
        textColor={color}
      />
    );
  };

  return (
    <View style={surveyBodyStyles.container}>
      <FlatList
        data={options}
        renderItem={renderItem}
        keyExtractor={() => keygen._()}
        extraData={selected}
      />
    </View>
  );
};

const surveyBodyStyles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight || 0,
  },
});

export default SurveyBody;
