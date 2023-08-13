import { View, StyleSheet, Dimensions, TouchableOpacity } from "react-native";
import React, { useState, useRef } from "react";
import { Video, ResizeMode } from "expo-av";
import SurveyBody from "./SurveyBody";
export default function SurveyCard() {
  const [status, setStatus] = useState({});
  const video = useRef(null);

  return (
    <View style={surveyCardStyles.container}>
      <TouchableOpacity
        onPress={() =>
          status.isPlaying
            ? video.current.pauseAsync()
            : video.current.playAsync()
        }
      >
        <Video
          ref={video}
          style={surveyCardStyles.video}
          source={{
            uri: "https://y.yarn.co/50e48925-0d48-4cd2-bdad-3bc7959e3cac.mp4",
          }}
          useNativeControls={false}
          resizeMode={ResizeMode.STRETCH}
          isLooping
          onPlaybackStatusUpdate={(status) => setStatus(() => status)}
        />
      </TouchableOpacity>

      <View style={surveyCardStyles.body}>
        <SurveyBody />
      </View>
    </View>
  );
}
const surveyCardStyles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#EFEFEF",
  },
  video: {
    alignSelf: "center",
    width: Dimensions.get("screen").width,
    height: 200,
  },
  body: {
    flex: 1,
  },
});
