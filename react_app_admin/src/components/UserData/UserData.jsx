import { useState } from "react"
import "./UserData.css"
import send_request from "../../configurations/request_function"

const UserData = ({username, user_id, email, deleted_at}) => {

const [deletedUser, setDeletedUser] = useState(deleted_at)

const handle_delete_user = async (email) => {
      try {
      const token = localStorage.getItem('token')
      const response = await send_request({
        route: "/delete_user",
        body: {"email" : email},
        method: "POST",
        headerValue: `Bearer ${token}`
      })
      setDeletedUser('deleted')
    } catch (error) {
      // console.log(error.response)
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
      setDeletedUser('null')
      console.log(response.data)
    } catch (error) {
      console.log(error.response)
    }
  
}

  return <>
          <td style={{ 
            color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)",
            // backgroundColor : deletedUser === "null" ?  null : "var(--darkGrey)" 
            }}>{user_id}</td> 

          <td style={{ 
            color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)",
            // backgroundColor : deletedUser === "null" ?  null : "var(--darkGrey)" 
            }}>{username}</td>

          <div className="email-button-row">
            <td style={{
                color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)",
              //  backgroundColor : deletedUser === "null" ?  null : "var(--darkGrey)" 
                }}>{email}</td>

            {deletedUser !== "null" ?
              <img className="arrow" src="images/add-user.png" alt="arrow" 
                onClick={() => handle_restore_user(email)} 
              /> : null}

            {deletedUser === "null" ? 
              <img className="trash" src="images/trash.png" alt="trash" 
                onClick={() => handle_delete_user(email)} 
                /> : null}
          </div>
  </>
}

export default UserData

