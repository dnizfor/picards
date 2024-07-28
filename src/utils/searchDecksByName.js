function searchDecksByName(searchTerm, sets) {
  const results = [];

  for (let i = 0; i < sets.length; i++) {
    const set = sets[i];
    if (set.deck.toLowerCase().includes(searchTerm.toLowerCase())) {
      results.push(set);
    }
  }

  return results;
}

export default searchDecksByName;
