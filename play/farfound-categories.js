// Category flights: 7 question categories and Flags. A category flies 8 of its prompts: bank prompts of the listed
// card types or exact texts, plus its own prompts (same row shape as the bank). Flags lives in farfound-flags.js.
window.FARFOUND_CATEGORIES = {
  cats: [
    { key: "sport", name: "Sport", blurb: "Players, teams, rules and records from every sport.",
      bank: ["sport"], texts: [],
      prompts: [
      ] },
    { key: "food", name: "Food & Drink", blurb: "Dishes, snacks and drinks from every kitchen on Earth.",
      bank: ["food"], texts: [],
      prompts: [
      ] },
    { key: "screen", name: "Film, TV & Music", blurb: "Films, shows, songs, stars and the people behind them.",
      bank: ["pop"], texts: ["Name a musical instrument","Name an opera, ballet or stage musical (The Lion King counts)","Name a classical music composer from any era or country (film composers don't count)","Name a music term or instrument that comes from Italian (like allegro)","Name a dance or dance move"],
      prompts: [
      ] },
    { key: "geo", name: "Geography", blurb: "Countries, cities, rivers, mountains and the places between.",
      bank: ["geo"], texts: [],
      prompts: [
      ] },
    { key: "nature", name: "Animals & Nature", blurb: "Creatures, plants, weather and the wild.",
      bank: ["nature"], texts: [],
      prompts: [
      ] },
    { key: "science", name: "Science & Space", blurb: "The body, the elements, inventions and the sky above.",
      bank: ["science","space"], texts: [],
      prompts: [
      ] },
    { key: "history", name: "History & Famous People", blurb: "Rulers, empires, explorers and the people who changed things.",
      bank: [], texts: ["Name a real king, queen, emperor or other ruler who came to power before 1800 (Cleopatra counts)","Name a Nobel Prize winner (people and organisations count)","Name a philosopher from any culture or era (Confucius counts)","Name a real person who is or was on a banknote anywhere in the world (Frida Kahlo counts)","Name a painter, sculptor or other visual artist (photographers and cartoonists count)","Name an author of children's books (Roald Dahl counts)"],
      prompts: [
      ] },
  ],
};
