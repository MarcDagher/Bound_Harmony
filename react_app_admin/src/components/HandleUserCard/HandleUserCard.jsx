import { useState } from "react"
import "./HandleUserCard.css"
import send_request from "../../configurations/request_function"

const HandleUsersCard = ({buttonText, boxTitle, handle_submit}) => {

  const [formEmail, setFormEmail] = useState("")
  const [deleteUserResponseMessage, setDeleteUserResponseMessage] = useState('')

  const handle_change = (value) => {
    setFormEmail(value)
  }
  const handle_delete_user_submit = async (email) => {
    if (email === ""){
      setDeleteUserResponseMessage('All fileds are required')
    } else {
        try {
        const token = localStorage.getItem('token')
        const response = await send_request({
          route: "/delete_user",
          body: email,
          method: "POST",
          headerValue: `Bearer ${token}`
        })
        console.log(response.data)
        // setDeleteUserResponseMessage('success')
    
      } catch (error) {
        console.log(error.response)
        // setDeleteUserResponseMessage('error')
      }
    }
    
  }
  // console.log(formEmail)

  return <>
    <div className="admin-box-container">
            <p>{boxTitle}</p>
            <div className="admin-input-container">
              <input type="text" name="email" id="email" placeholder="email" onChange={(e) => handle_change(e.target.value)} required/>
              {setDeleteUserResponseMessage !== "" ? <p className="error_message">{deleteUserResponseMessage}</p>  : null}
              {/* {successMessage !== "" ? <p className="error_message">{successMessage}</p>  : null} */}
            </div>
            <button type="button" onClick={() => {handle_delete_user_submit(formEmail)}}>{buttonText}</button>
    </div>
  </>
}

export default HandleUsersCard