import { useState } from "react"
import "./HandleUserCard.css"
import send_request from "../../configurations/request_function"

const HandleUsersCard = ({buttonText, boxTitle}) => {

  const [formEmail, setFormEmail] = useState("")
  const [deleteUserResponseMessage, setDeleteUserResponseMessage] = useState('')

  const handle_change = (value) => {
    setFormEmail(value)
  }

  const handle_delete_user = async (email) => {

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

  const handle_restore_user = async (email) => {
    const email_regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (email === ""){
      setDeleteUserResponseMessage('All fileds are required')
    } 
    else if (!email_regex.test(email)) {
      setDeleteUserResponseMessage("Invalid email format");
    } 
    else {
        try {
        const token = localStorage.getItem('token')
        const response = await send_request({
          route: "/restore_deleted_user",
          body: {"email" : email},
          method: "POST",
          headerValue: `Bearer ${token}`
        })
        if (response.data['status'] === "rejected"){
          setDeleteUserResponseMessage(response.data.message)
        } else if (response.data['status'] === "success") {
          setDeleteUserResponseMessage("User restored successfuly")
        }
        console.log(response.data['status'])
        // setDeleteUserResponseMessage('success')
      } catch (error) {
        console.log(error.response)
        // setDeleteUserResponseMessage('error')
      }
    }
  }
  

  return <>
    <div className="admin-box-container">
            <p>{boxTitle}</p>
            <div className="admin-input-container">
              <input type="text" name="email" id="email" placeholder="email" onChange={(e) => handle_change(e.target.value)} required/>
              {setDeleteUserResponseMessage !== "" ? <p className="error_message">{deleteUserResponseMessage}</p>  : null}
            </div>
            <button type="button" onClick={() => {
              buttonText === "Delete User" ? handle_delete_user(formEmail) : handle_restore_user(formEmail)
              }}>{buttonText}</button>
    </div>
  </>
}

export default HandleUsersCard