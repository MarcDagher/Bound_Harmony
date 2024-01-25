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
        setnumberOfChosenResponses(value.data['Number of chosen responses'])
      })
  }

  // number_of_chosen_responses
  useEffect(()  => {
    try {
      getNumberOfChosenResponses()
    } catch (error) {
      console.log(error)
    }

  }, [])
  
  return <>
  <div className="survey-reponses-wrapper">
    {<SideBar />}
    <div className="survey-responses-cards">
      <p>Survey Responses</p>

      {numberOfChosenResponses &&
          Object.entries(numberOfChosenResponses).map(([key, value]) => (
            <div key={key} className="survey-questions">

              <p><span className="span-question">Question: </span> {`${key}`}</p>
              <p className="span-option">Answers:</p>
              <div className="survey-question-responses">

                  {Object.entries(value).map(([obj_key, obj_value]) => (
                    
                    <p className="option-number" key={obj_key}>{`${obj_key}: `} <span className="number-span">{`${obj_value}`}</span></p>
                  ))}

              </div>

            </div>
          ))}


    </div>
  </div>
  </>
}

export default SurveyResponses