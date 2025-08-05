import logo from './logo.svg';
import './App.css';
import { CalculatorScore } from './Components/CalculateScore';

function App() {
  return (
    <div className="App">
    <CalculatorScore name={"Avilash"} school={"SJHS"} total={284} goal={3} />
    </div>
  );
}

export default App;
