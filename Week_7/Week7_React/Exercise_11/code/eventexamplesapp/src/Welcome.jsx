import React from 'react';

function Welcome() {
  const sayMessage = (msg) => {
    alert(msg);
  };

  return (
    <div>
      <button onClick={() => sayMessage("Welcome")}>Say Welcome</button>
    </div>
  );
}

export default Welcome;
