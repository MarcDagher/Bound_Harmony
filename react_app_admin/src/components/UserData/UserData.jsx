import { useState } from "react"
import "./UserData.css"
import send_request from "../../configurations/request_function"

const UserData = ({username, user_id, email, deletad_at}) => {

const [deleteUserResponseMessage, setDeleteUserResponseMessage] = useState('')


const handle_delete_user = async (email) => {
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
      console.log(response.data)
    } catch (error) {
      console.log(error.response)
    }
}

const handle_restore_user = async (email) => {

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
      console.log(response.data)
    } catch (error) {
      console.log(error.response)
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
              <img className="arrow" src="images/back-arrow.png" alt="arrow" onClick={() => handle_restore_user(email)}/>
              <img className="trash" src="images/trash.png" alt="trash" onClick={() => handle_delete_user(email)} />
            </div>
        </div>

    </div>
  </>
}

export default UserData

