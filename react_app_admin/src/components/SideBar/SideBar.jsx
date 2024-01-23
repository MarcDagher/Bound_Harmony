import { useLocation, useNavigate } from "react-router-dom"
import "./SideBar.css" 
import send_request from "../../configurations/request_function"
import { useState } from "react"
const SideBar = () => {

  const navigate = useNavigate()
  const location = useLocation()
  // background-color: rgb(56, 56, 56);
  const currentLocation = location.pathname.split('/')[1]

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

  
  console.log(currentLocation)

  return <>
      <div className='admin-sidebar'>

        <div className="dashboard" style={{backgroundColor: currentLocation === "dashboard" ? "rgb(56, 56, 56)" : null}}>
            <span onClick={() => {navigate('/dashboard')}  }>Dashboard</span>
        </div>

        <div className="users" style={{backgroundColor: currentLocation === "users" ? "rgb(56, 56, 56)" : null}}>
            <span onClick={() => navigate('/users')}>Users</span>
        </div>

        <div className="survey-responses" style={{backgroundColor: currentLocation === "survey_responses" ? "rgb(56, 56, 56)" : null}}>
            <span onClick={() => navigate('/survey_responses')}>Survey Responses</span>
        </div>

        <div className="logout">
            <span onClick={() => logout()}>Logout</span>
        </div>

    </div>
  </>
}

export default SideBar