import { useEffect, useState } from 'react';
import './admin_page.css';
import send_request from "../../configurations/request_function";
// import BarsDataset from '../../components/DatasetBarCharts/ConnectionsStats';
// import { BarChart } from '@mui/x-charts';
// import BasicBars from '../../components/BasicBarchart/BasicBarChart';
import ConnectionsStats from '../../components/DatasetBarCharts/ConnectionsStats';
import SurveysStats from '../../components/DatasetBarCharts/SurveysStats';
// import AgeRangeStats from '../../components/PieChart/AgeRangeStats';
import HandleUsersCard from '../../components/HandleUserCard/HandleUserCard';

const Admin = () => {

  const [connectionAndSurveyStats, setconnectionAndSurveyStats] = useState({
    all_survey_responses : 0,
    couple_survey_responses : 0,
    personal_survey_responses : 0,
    number_of_connections : 0,
    accepted_connections : 0,
    disconnected_connections : 0,
    pending_connections : 0,
    rejected_connections : 0
  })
  const [numberOfChosenResponses, setnumberOfChosenResponses] = useState()
  const [usersAgeRange, setUsersAgeRange] = useState({
    above_35 : 0,
    below_18 : 0,
    between_18_and_24 : 0,
    between_24_and_35 : 0,
    total_users : 0,
  })

  const getConnectionAndSurveyStats = async () => {
     await send_request({
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
    })
  }

  const getNumberOfChosenResponses = async () => {
    await send_request({
      body: {}, 
      route: '/number_of_chosen_responses', 
      headerValue: `Bearer ${token}`, 
      method: "GET"}).then((value) => {
        // console.log(value)
        setnumberOfChosenResponses(value.data['Number of chosen responses'])
      })
  }
  
  const getUsersAgeRange = async () => {
    await send_request({
      body:{},
      route: '/users_age_range',
      method: 'GET',
      headerValue: `Bearer ${token}`
    }).then((value) => {
      // console.log(value.data)
      setUsersAgeRange({
        above_35 : value.data['above_35'],
        below_18 : value.data['below_18'],
        between_18_and_24 : value.data['between_18_and_24'],
        between_24_and_35 : value.data['between_24_and_35'],
        total_users : value.data['total users'],
      })

    })
  }
  
  const token = localStorage.getItem('token')
  ///connection_and_surveys_stats
  useEffect(() => {
    try {
      getConnectionAndSurveyStats()
      // console.log("in connectionAndSurveyStats")
    } catch (error) {
      console.log(error)
    }
    // console.log(connectionAndSurveyStats)
  } ,[token])

  // number_of_chosen_responses
  useEffect(()  => {
    try {
      getNumberOfChosenResponses()
      // console.log("in numberOfChosenResponses")
    } catch (error) {
      console.log(error)
    }
    // console.log(numberOfChosenResponses)
    
  }, [token])
 
  // user age range
  useEffect( () => {
    try {
      getUsersAgeRange()
      // console.log("in user age range")
    } catch (error) {
      console.log(error)
    }
    // console.log(usersAgeRange)
  },[token])

  const handle_delete_user_submit = ({email}) => {
    try {
      const response = send_request({
        route: "/delete_user",
        body: email,
        method: "POST",
        headerValue: `Bearer ${token}`
      })
      console.log(response)
    } catch (error) {
      console.log(error)
    }
  }

  // console.log(numberOfChosenResponses)

  return <>
  <div className='admin-wrapper'>
    
    <div className='admin-header'>
        <p>Admin's Dashboard</p>
    </div>

  <div className='admin-stat-cards'>

    <div className='number-of-users'>
      <img src="/images/user.png" alt="user" />
      <p>Number of Users</p>
      <p>{usersAgeRange['total_users']}</p>
    </div>

    <div className='number-of-answered-surveys'>
      <img src="/images/carousel.png" alt="survey" />
      <p>Number of Surveys Answered</p>
      <p>{connectionAndSurveyStats['all_survey_responses']}</p>
    </div>

    <div className='number-of-connections'>
      <img src="/images/friend-request.png" alt="request" />
      <p>Number of Connection Requests</p>
      <p>{connectionAndSurveyStats['number_of_connections']}</p>
    </div>

  </div>


    <div className='admin-graphs'>
      <div className='admin-bar-charts'>

        {/* /// trying to put graohs in card */}
        {/* <div className='bar-chart-connections'> */}
            {ConnectionsStats({connectionAndSurveyStats})}
        {/* </div> */}
        {/* <div className='bar-chart-surveys'> */}
            {SurveysStats({connectionAndSurveyStats})}
        {/* </div> */}
        
      </div>
        {/* {AgeRangeStats({usersAgeRange})} */}
    </div>

    <div className='admin-handle-user-cards'>

        <div className='delete-user'>
            {HandleUsersCard({
              buttonText: "Delete User",
              boxTitle: "Enter User's Email",
              handle_submit: handle_delete_user_submit
              })}
        </div>

        <div className='restore-user'>
            {HandleUsersCard({
              buttonText: "Restore User",
              boxTitle: "Enter User's Email"
              })}
        </div>

    </div>

  </div>
  </>
}

export default Admin;