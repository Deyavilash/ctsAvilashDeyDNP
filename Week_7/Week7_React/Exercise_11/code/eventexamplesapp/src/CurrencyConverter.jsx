import React, { useState } from 'react';

function CurrencyConverter() {
  const [rupees, setRupees] = useState('');
  const [euro, setEuro] = useState('');

  const handleChange = (e) => {
    setRupees(e.target.value);
  };

  const handleSubmit = () => {
    const converted = (parseFloat(rupees) / 90).toFixed(2);
    setEuro(converted);
  };

  return (
    <div>
      <h2>Currency Converter</h2>
      <input type="number" value={rupees} onChange={handleChange} placeholder="Enter Rupees" />
      <button onClick={handleSubmit}>Convert</button>
      {euro && <p>Euro: €{euro}</p>}
    </div>
  );
}

export default CurrencyConverter;
