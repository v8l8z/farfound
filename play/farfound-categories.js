// Category flights: 7 question categories and Flags. A category flies 8 of its prompts: bank prompts of the listed
// card types or exact texts, plus its own prompts (count of them here; the prompts are in farfound-cat-prompts.js,
// loaded after the game starts). hidden: no tile on Home for now. Built by farfound-content/categories/assemble.js.
window.FARFOUND_CATEGORIES = {
  cats: [
    { key: "sport", name: "Sport", blurb: "Players, teams, rules and records from every sport.", count: 104,
      bank: ["sport"], texts: [] },
    { key: "food", hidden: true, name: "Food & Drink", blurb: "Dishes, snacks and drinks from every kitchen on Earth.", count: 87,
      bank: ["food"], texts: [] },
    { key: "screen", name: "Film, TV & Music", blurb: "Films, shows, songs, stars and the people behind them.", count: 97,
      bank: ["pop"], texts: ["Name a musical instrument","Name an opera, ballet or stage musical (The Lion King counts)","Name a classical music composer from any era or country (film composers don't count)","Name a music term or instrument that comes from Italian (like allegro)","Name a dance or dance move"] },
    { key: "geo", name: "Geography", blurb: "Countries, cities, rivers, mountains and the places between.", count: 104,
      bank: ["geo"], texts: [] },
    { key: "nature", name: "Animals & Nature", blurb: "Creatures, plants, weather and the wild.", count: 90,
      bank: ["nature"], texts: [] },
    { key: "science", name: "Science & Space", blurb: "The body, the elements, inventions and the sky above.", count: 88,
      bank: ["science","space"], texts: [] },
    { key: "history", name: "History & Famous People", blurb: "Rulers, empires, explorers and the people who changed things.", count: 113,
      bank: [], texts: ["Name a real king, queen, emperor or other ruler who came to power before 1800 (Cleopatra counts)","Name a Nobel Prize winner (people and organisations count)","Name a philosopher from any culture or era (Confucius counts)","Name a real person who is or was on a banknote anywhere in the world (Frida Kahlo counts)","Name a painter, sculptor or other visual artist (photographers and cartoonists count)","Name an author of children's books (Roald Dahl counts)"] },
  ],
};
