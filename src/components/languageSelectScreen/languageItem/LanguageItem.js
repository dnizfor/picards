import React from "react";
import { Dimensions, Image, StyleSheet, Text } from "react-native";
import RNBounceable from "@freakycoder/react-native-bounceable";

const windowWidth = Dimensions.get("window").width;

const LanguageItem = ({
  itemContainer,
  item,
  width = windowWidth * 0.9,
  height = 80,
  isActive,
  backgroundColor = "#FFFFFF",
  textColor = "#2F3452",
  imageComponent,
  checkComponent,
  activeBorderColor = "#504ED9",
  rightImageSource,
  onSelect,
}) => {
  const borderColor = isActive ? activeBorderColor : backgroundColor;
  return (
    <RNBounceable
      style={[
        _itemContainer(backgroundColor, borderColor, width, height),
        itemContainer,
      ]}
      onPress={() => onSelect && onSelect(item)}
    >
      {imageComponent || (
        <Image source={item.imageSource} style={languageItemStyle.imageStyle} />
      )}
      <Text style={_titleStyle(textColor)}>{item.title}</Text>
      {isActive &&
        (checkComponent || (
          <Image
            source={
              rightImageSource || require("../../../assets/images/check.png")
            }
            style={languageItemStyle.checkImageStyle}
          />
        ))}
    </RNBounceable>
  );
};

const _itemContainer = (backgroundColor, borderColor, width, height) => ({
  borderColor: borderColor,
  backgroundColor: backgroundColor,
  borderWidth: 2,
  borderRadius: 20,
  height: height,
  width: width,
  marginBottom: 12,
  flexDirection: "row",
  alignItems: "center",
  paddingLeft: 24,
});

const _titleStyle = (color) => ({
  fontWeight: "600",
  color: color,
  fontSize: 16,
});
const languageItemStyle = StyleSheet.create({
  imageStyle: {
    width: 40,
    height: 40,
    marginRight: 18,
  },
  checkImageStyle: {
    position: "absolute",
    right: 24,
    width: 20,
    height: 20,
  },
});

export default LanguageItem;
