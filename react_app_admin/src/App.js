import {BrowserRouter, Route, Routes} from "react-router-dom";
import Login from "./pages/login_page/login"
import Dashboard from "./pages/dashboard_page/dashboard_page";
import Users from "./pages/users_page/UsersPage";
import SurveyResponses from "./pages/survey_responses_page/SurveyResponses";
function App() {
  return <>
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Login />}></Route>
      <Route path="/dashboard" element={<Dashboard />}></Route>
      <Route path="/users" element={<Users />}></Route>
      <Route path="/surveysResponses" element={<SurveyResponses />}></Route>
    </Routes>
  </BrowserRouter>
  </>
}

export default App;
