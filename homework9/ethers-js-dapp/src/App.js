import { useState } from "react";
import { ethers } from "ethers";
 
function App() {
  let [text, setText] = useState("");
  let [savedText, setSavedText] = useState("");
  let [connected, setConnected] = useState(false);
 
  let { ethereum } = window;
  let contract = null;
 
  if (ethereum) {
 
    let abi = [
      "function changeText(string)",
      "function text() view returns (string)"
    ]
    let address = "0x1C3dd5c848102ac51E1c47434a00eFbEd1F177C4";
    let provider = new ethers.providers.Web3Provider(ethereum);
    let signer = provider.getSigner();
    contract = new ethers.Contract(address, abi, signer);
  }
 
  return (
    <div className="App">
      <h1>Text Contract</h1>
 
      <button onClick={() => {
          if (contract && !connected) {
              ethereum.request({ method: 'eth_requestAccounts'})
                  .then(accounts => {
                      setConnected(true);
                  })
          }
      }}>{!connected ? 'Connect wallet' : 'Connected' }</button>
 
      <form onSubmit={(e) => {
        e.preventDefault();
        if (contract && connected) {
          contract.changeText(text)
            .then(() => {
              setText("");
            });
        }
      }}>
          <input type="text" placeholder="Enter text" onChange={e => setText(e.currentTarget.value)} value={text} />
          <input type="submit" value="Change text" />
      </form>
 
      <button onClick={() => {
        if (contract && connected) {
          contract.text()
            .then(text => {
              setSavedText(text);
            })
        }
      }}>Get text</button>
 
      <h3>{savedText}</h3>
    </div>
  );
}
 
export default App;
