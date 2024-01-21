import { useEffect, useState } from 'react';
import './admin_page.css';
import send_request from "../../configurations/request_function";

const Admin = () => {
  const token = localStorage.getItem('token')

  const [connectionAndSurveyStats, setconnectionAndSurveyStats] = useState({
    all_survey_responses : '',
    couple_survey_responses : '',
    personal_survey_responses : '',
    accepted_connections : '',
    disconnected_connections : '',
    number_of_connections : '',
    pending_connections : '',
    rejected_connections : ''
  })

  useEffect(() => {
    console.log("hello")
    try {
      const response = send_request({
        body:{},
        route: '/connection_and_surveys_stats',
        method: 'GET',
        headerValue: `Bearer ${token}`
      })
      .then((value) => {
        // console.log(value.data)
        setconnectionAndSurveyStats({
          number_of_connections : value.data['number of connections'] ,
          accepted_connections : value.data['accepted connections'],
          all_survey_responses : value.data['All Survey Responses'],
          couple_survey_responses : value.data['Couple Survey Responses'],
          disconnected_connections : value.data['disconnected connections'],
          pending_connections : value.data['pending connections'],
          personal_survey_responses : value.data['Personal Survey Responses'],
          rejected_connections : value.data['rejected connections'],
        })
        // console.log(connectionAndSurveyStats)
      })

    } catch (error) {
      console.log(error)
    }
  } ,[token])

  useEffect(() => {
    const response = send_request({
      body: {}, 
      route: '/number_of_chosen_responses', 
      headerValue: `Bearer ${token}`, 
      method: "GET"}).then((value) => console.log(value.data))
  }, [token])

  

  return <>
    <p>Hello</p>
  </>
}

export default Admin;