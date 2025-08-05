import React from 'react';

function SyntheticEvent() {
  const handleClick = (event) => {
    alert("I was clicked");
    console.log("Synthetic event: ", event);
  };

  return (
    <div>
      <button onClick={handleClick}>Click Me</button>
    </div>
  );
}

export default SyntheticEvent;
