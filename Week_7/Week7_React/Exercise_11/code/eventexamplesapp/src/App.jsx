import React from 'react';
import Counter from './Counter';
import Welcome from './Welcome';
import SyntheticEvent from './SyntheticEvent';
import CurrencyConverter from './CurrencyConverter';

function App() {
  return (
    <div className="App">
      <h1>Event Examples App</h1>
      <Counter />
      <Welcome />
      <SyntheticEvent />
      <CurrencyConverter />
    </div>
  );
}

export default App;
