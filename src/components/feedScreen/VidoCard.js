import { View, Text, Dimensions } from "react-native";
import React, { useState, useRef, useEffect } from "react";
import { StyleSheet } from "react-native";
import { Video, ResizeMode } from "expo-av";
import { TouchableOpacity } from "react-native";

export default function VidoCard({word,mean,videoUrl,isVisible}) {
  const [status, setStatus] = useState({});
  const video = useRef(null);
 
useEffect(async()=>{
  if(isVisible){
    await Audio.setAudioModeAsync({ playsInSilentModeIOS: true })
    video.current.playAsync()
  }else{
    video.current.pauseAsync()
  }

},[isVisible])
  return (
    <View style={vidoCardStyle.container}>
      <View style={vidoCardStyle.titleContainer}>
        <Text style={vidoCardStyle.title}>
          {word}
        </Text>
      </View>
      <View style={vidoCardStyle.videoContainer}>
        <TouchableOpacity
          onPress={() =>
            status.isPlaying
              ? video.current.pauseAsync()
              : video.current.playAsync()
          }
        >
          <Video
            ref={video}
            style={styles.video}
            source={{
              uri: videoUrl,
            }}
            useNativeControls={false}
            resizeMode={ResizeMode.STRETCH}
            isLooping
            onPlaybackStatusUpdate={(status) => setStatus(() => status)}
          />
        </TouchableOpacity>
      </View>

      <View style={vidoCardStyle.titleContainer}>
        <Text style={vidoCardStyle.title}>{mean}</Text>
      </View>
    </View>
  );
}

const vidoCardStyle = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "space-around",
  },
  videoContainer: {
    flex: 1,
    justifyContent: "center",
  },
  titleContainer: {
    flex: 1,
    padding: 20,
    justifyContent: "center",
  },

  title: { fontWeight: "bold", fontSize: 30, textAlign: "center" },
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    backgroundColor: "#ecf0f1",
  },
  video: {
    alignSelf: "center",
    width: Dimensions.get("screen").width,
    height: 200,
  },
  buttons: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
  },
});
