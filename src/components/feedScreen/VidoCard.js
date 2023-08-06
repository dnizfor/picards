import { View, Text, Dimensions } from "react-native";
import React, { useState, useRef, useEffect } from "react";
import { StyleSheet } from "react-native";
import { Video, ResizeMode } from "expo-av";
import { TouchableOpacity } from "react-native";

export default function VidoCard() {
  const [status, setStatus] = useState({});
  const video = useRef(null);

  return (
    <View style={vidoCardStyle.container}>
      <View>
        <Text style={vidoCardStyle.title}>
          VidoCardVidoCardVidoCardVidoCardVidoCar
        </Text>
      </View>
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
            uri: "https://y.yarn.co/50e48925-0d48-4cd2-bdad-3bc7959e3cac.mp4",
          }}
          useNativeControls={false}
          resizeMode={ResizeMode.STRETCH}
          isLooping
          onPlaybackStatusUpdate={(status) => setStatus(() => status)}
        />
      </TouchableOpacity>
      <View>
        <Text style={vidoCardStyle.title}>VidoCardVidoCard</Text>
      </View>
    </View>
  );
}

const vidoCardStyle = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "space-around",
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
