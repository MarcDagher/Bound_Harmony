import {BrowserRouter, Route, Routes} from "react-router-dom";
import Admin from "./pages/admin_page";
function App() {
  return <>
  <BrowserRouter>
    <Routes>
      <Route path="/admin" element={<Admin />}></Route>
    </Routes>
  </BrowserRouter>
  </>
}

export default App;
