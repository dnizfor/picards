import vocabularyData from "../assets/jsons/data.json"


export const getWordsByDeckName = (deckName) => {
  return vocabularyData.filter((item) => item.deck === deckName);
};
