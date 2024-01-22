import {BrowserRouter, Route, Routes} from "react-router-dom";
import Login from "./pages/login_page/login"
import Dashboard from "./pages/dashboard_page/dashboard_page";
function App() {
  return <>
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Login />}></Route>
      <Route path="/dashboard" element={<Dashboard />}></Route>
    </Routes>
  </BrowserRouter>
  </>
}

export default App;
