import { useNavigate } from "react-router-dom"
import "./SideBar.css" 
import send_request from "../../configurations/request_function"
const SideBar = () => {

  const navigate = useNavigate()

  const logout = async () => {
    const token = localStorage.getItem('token')
    try {
      send_request({
        body:{},
        headerValue: `Bearer ${token}`,
        route: '/logout',
        method: 'POST'
      })
      localStorage.removeItem('token')
      navigate('/')
    } catch (error) {
      // console.log(error)
    }
  }
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
            <span onClick={() => logout()}>Logout</span>
        </div>
    </div>
  </>
}

export default SideBar