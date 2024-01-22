import { useNavigate } from "react-router-dom"
import "./SideBar.css" 
const SideBar = () => {

  const navigate = useNavigate()

  return <>
      <div className='admin-sidebar'>
        <div className="dashboard">
            <span onClick={() => navigate('/dashboard')}>Dashboard</span>
        </div>
        <div className="users">
            <span onClick={() => navigate('/users')}>Users</span>
        </div>
        <div className="survey-responses">
            <span onClick={() => navigate('/survey_responses')}>Survey Responses</span>
        </div>
        <div className="logout">
            <span onClick={() => navigate('/')}>Logout</span>
        </div>
    </div>
  </>
}

export default SideBar