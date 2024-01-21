import {BrowserRouter, Route, Routes} from "react-router-dom";
import Admin from "./pages/admin_page/admin_page";
import Login from "./pages/login_page/login"
function App() {
  return <>
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Login />}></Route>
      <Route path="/admin" element={<Admin />}></Route>
    </Routes>
  </BrowserRouter>
  </>
}

export default App;
