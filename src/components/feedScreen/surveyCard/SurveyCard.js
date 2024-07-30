import { View, StyleSheet, Dimensions, TouchableOpacity } from "react-native";
import React, { useState, useRef, useEffect, useCallback } from "react";
import { Video, ResizeMode } from "expo-av";
import SurveyBody from "./SurveyBody";
import { generateOptions } from "../../../utils/optionsCreator";

export default function SurveyCard({videoUrl,mean,isVisible}) {
  const [status, setStatus] = useState({});
  const [options, setOptions] = useState({});
  const video = useRef(null);
  useEffect(()=>{
    if(isVisible){
      video.current.playAsync()
    }else{
      video.current.pauseAsync()
    }
  
  },[isVisible])
  useEffect(()=>{
    const options =(generateOptions(mean))
    setOptions(options)
    
  },[])
  
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
            uri: videoUrl,
          }}
          useNativeControls={false}
          resizeMode={ResizeMode.STRETCH}
          isLooping
          onPlaybackStatusUpdate={(status) => setStatus(() => status)}
        />
      </TouchableOpacity>

      <View style={surveyCardStyles.body}>
        <SurveyBody options={options} />
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
