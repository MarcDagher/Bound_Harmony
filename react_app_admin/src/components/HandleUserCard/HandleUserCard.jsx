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

    const email_regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (email === ""){
      setDeleteUserResponseMessage('All fileds are required')
    } 
    else if (!email_regex.test(email)) {
      setDeleteUserResponseMessage("Invalid email format");
    } 
    else {
      console.log(email)
        try {
        const token = localStorage.getItem('token')
        const response = await send_request({
          route: "/delete_user",
          body: {"email" : email},
          method: "POST",
          headerValue: `Bearer ${token}`
        })
        if (response.data['status'] === "rejected"){
          setDeleteUserResponseMessage(response.data.message)
        } else if (response.data['status'] === "success") {
          setDeleteUserResponseMessage("User deleted successfuly")
        }
        console.log(response.data['status'])
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