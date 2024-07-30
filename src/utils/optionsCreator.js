import vocabularyData from "../assets/jsons/data.json"


export const generateOptions = (correctAnswer) => {

  const incorrectOptions = vocabularyData.filter(item => item.word !== correctAnswer);
  
  const shuffledIncorrectOptions = incorrectOptions.sort(() => 0.5 - Math.random());
  const selectedIncorrectOptions = shuffledIncorrectOptions.slice(0, 3);

  const allOptions = [...selectedIncorrectOptions, {mean:correctAnswer}].sort(() => 0.5 - Math.random());
  return allOptions.map(option => ({
    option: option.mean ||correctAnswer ,
    isAnswer:correctAnswer ==option.mean
  }));

};
