import React from 'react';

function App() {
  const office = {
    name: 'DBS',
    rent: 50000,
    address: 'Chennai',
    image: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=800&q=60'
  };

  const rentStyle = {
    color: office.rent < 60000 ? 'red' : 'green',
    fontWeight: 'bold'
  };

  return (
    <div style={{ textAlign: 'center', fontFamily: 'Arial', marginTop: '40px' }}>
      <h1>Office Space , at Affordable Range</h1>

      <img
        src={office.image}
        alt="Office Space"
        style={{ width: '300px', height: '200px', objectFit: 'cover', margin: '20px auto', display: 'block' }}
      />

      <div style={{ textAlign: 'left', width: '300px', margin: '0 auto', fontSize: '18px' }}>
        <p><strong>Name:</strong> {office.name}</p>
        <p style={rentStyle}>Rent: Rs. {office.rent}</p>
        <p><strong>Address:</strong> {office.address}</p>
      </div>
    </div>
  );
}

export default App;
