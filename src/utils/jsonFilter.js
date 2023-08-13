import all_decks from "../assets/jsons/deck_list.json";
import all_words from "../assets/jsons/vocabulary_list.json";
import all_videos from "../assets/jsons/vocabulary_list.json";

export const getSetDataById = (id) => {
  return all_decks.find((item) => item.deck_id === id);
};

export const getWordsBySetId = (id) => {
  return all_words.filter((item) => item.deck_id === id);
};
export const getVideosByWordId = (id) => {
  return all_videos.filter((item) => item.word_id === id);
};
