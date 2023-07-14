import all_sets from "../assets/jsons/set_list.json";
import all_words from "../assets/jsons/vocabulary_list.json";
import all_videos from "../assets/jsons/vocabulary_list.json";

export const getSetDataById = (id) => {
  return all_sets.find((item) => item.set_id === id);
};

export const getWordsBySetId = (id) => {
  return all_words.filter((item) => item.set_id === id);
};
export const getVideosByWordId = (id) => {
  return all_videos.filter((item) => item.word_id === id);
};
