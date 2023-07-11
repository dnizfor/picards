function searchSetsByName(searchTerm, sets) {
  const results = [];

  for (let i = 0; i < sets.length; i++) {
    const set = sets[i];
    if (set.set_name.toLowerCase().includes(searchTerm.toLowerCase())) {
      results.push(set);
    }
  }

  return results;
}

export default searchSetsByName;
