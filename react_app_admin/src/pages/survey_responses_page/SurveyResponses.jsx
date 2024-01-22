import { useEffect, useState } from "react"
import SideBar from "../../components/SideBar/SideBar"
import './SurveyResponses.css'
import send_request from "../../configurations/request_function"
const SurveyResponses = () => {

  const [numberOfChosenResponses, setnumberOfChosenResponses] = useState()

  const getNumberOfChosenResponses = async () => {
    const token = localStorage.getItem('token') 
    await send_request({
      body: {}, 
      route: '/number_of_chosen_responses', 
      headerValue: `Bearer ${token}`, 
      method: "GET"}).then((value) => {
        // console.log(value)
        setnumberOfChosenResponses(value.data['Number of chosen responses'])
      })
  }

  // number_of_chosen_responses
  useEffect(()  => {
    try {
      getNumberOfChosenResponses()
      // console.log("in numberOfChosenResponses")
    } catch (error) {
      console.log(error)
    }
    // console.log(numberOfChosenResponses)
    
  }, [])

  console.log("IN survey responses")
  console.log(numberOfChosenResponses)
  
  return <>
  <div className="survey-reponses-wrapper">
    {<SideBar />}
    <div className="survey-responses-cards">

    </div>
  </div>
  </>
}

export default SurveyResponses