import {BrowserRouter, Route, Routes} from "react-router-dom";
import Login from "./pages/login_page/login"
import Dashboard from "./pages/dashboard_page/dashboard_page";
import Users from "./pages/users_page/UsersPage";
function App() {
  return <>
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Login />}></Route>
      <Route path="/dashboard" element={<Dashboard />}></Route>
      <Route path="/users" element={<Users />}></Route>
    </Routes>
  </BrowserRouter>
  </>
}

export default App;
