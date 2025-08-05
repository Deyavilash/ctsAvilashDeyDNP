export const ListofPlayers = () => {
  const players = [

    { name: "Mohammed Siraj", score: 29 },
    { name: "Yuzvendra Chahal", score: 41 },
    { name: "Ishan Kishan", score: 77 },
    { name: "Shubman Gill", score: 71 },
    { name: "Rohit Sharma", score: 89 },
    { name: "Virat Kohli", score: 91 },
    { name: "KL Rahul", score: 68 },
    { name: "Rishabh Pant", score: 78 },
    { name: "Jasprit Bumrah", score: 16 },
    { name: "Suryakumar Yadav", score: 57 },
    { name: "Hardik Pandya", score: 37 },

  ];
  const playerList = players.map((player, index) => (
    <li key={index}>
      {player.name} - Score: {player.score}
    </li>
  ));
  const belowEighty = players
    .filter((player) => player.score < 70)
    .map((player, index) => (
      <li key={index}>
        {player.name} - Score: {player.score}
      </li>
    ));
  return (
    <div className="component-box">
      <h2>LIST OF PLAYERS</h2>
      <p> All 11 PLAYERS:</p>
      <ul>{playerList}</ul>
      <p>PLAYERS WITH BELOW 70 SCORE:</p>
      <ul>{belowEighty}</ul>
    </div>
  );
};
