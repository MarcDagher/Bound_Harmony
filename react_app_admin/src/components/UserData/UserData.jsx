import { useState } from "react"
import "./UserData.css"
import send_request from "../../configurations/request_function"

const UserData = ({buttonText, boxTitle,username, user_id, email, deletad_at}) => {

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
    <div className="user-data-container">
        <div className="user-data-with-buttons">
            <div className="user-data-container-cards">
                <p>Name: {username}</p>
                <p>Email: {email}</p>
                <p>{deletad_at === "null" ? "" : "DELETED"}</p>
            </div>
            <div className="user-data-buttons">
              
            </div>
        </div>

    </div>
  </>
}

export default UserData

