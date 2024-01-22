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

  // console.log("IN survey responses")
  // console.log(numberOfChosenResponses)
  // if (numberOfChosenResponses){
  //   for (const [key, value] of Object.entries(numberOfChosenResponses)){
  //     const value_obj = value
  //     console.log(`Key: ${key}, ${value}`)
  //     for (const [obj_key, obj_value] of Object.entries(value_obj)){
  //       console.log(`obj_key: ${obj_key}, ${obj_value}`)
  //     }
  //   }
  // }
  
  return <>
  <div className="survey-reponses-wrapper">
    {<SideBar />}
    <div className="survey-responses-cards">


      {numberOfChosenResponses &&
          Object.entries(numberOfChosenResponses).map(([key, value]) => (
            <div key={key} className="survey-questions">

              <p>{`Question: ${key}`}</p>
              <p>Options:</p>
              <div className="survey-question-responses">

                  {Object.entries(value).map(([obj_key, obj_value]) => (
                    
                    <p key={obj_key}>{`${obj_key}: ${obj_value}`}</p>

                  ))}

              </div>

            </div>
          ))}


    </div>
  </div>
  </>
}

export default SurveyResponses