import React, { useState } from "react";
import { Dimensions, FlatList } from "react-native";

import LanguageItem from "./languageItem/LanguageItem";

const windowWidth = Dimensions.get("window").width;
const windowHeight = Dimensions.get("window").height;

const LanguagePicker = ({
  data,
  flatListStyle,
  initialIndex = -1,
  containerWidth = windowWidth * 0.9,
  containerHeight = windowHeight * 0.7,
  onSelect,
  languageItemProps,
  ...rest
}) => {
  const [selectedItem, setSelectedItem] = useState(data[initialIndex]);

  const handleOnSelectItem = (item) => {
    setSelectedItem(item);
    onSelect && onSelect(item);
  };

  const renderItem = (item) => (
    <LanguageItem
      {...languageItemProps}
      onSelect={handleOnSelectItem}
      isActive={selectedItem === item}
      item={item}
    />
  );
  const _container = (width, height) => ({
    width: width,
    height: height,
  });
  return (
    <FlatList
      {...rest}
      data={data}
      style={[_container(containerWidth, containerHeight), flatListStyle]}
      renderItem={({ item }) => renderItem(item)}
      keyExtractor={(item) => item.title}
    />
  );
};

export default LanguagePicker;
