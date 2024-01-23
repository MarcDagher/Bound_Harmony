import { useState } from "react"
import "./UserData.css"
import send_request from "../../configurations/request_function"

const UserData = ({username, user_id, email, deleted_at, profile_pic_url}) => {

const [deletedUser, setDeletedUser] = useState(deleted_at)

const handle_delete_user = async (email) => {
      try {
      const token = localStorage.getItem('token')
      await send_request({
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
      await send_request({
        route: "/restore_deleted_user",
        body: {"email" : email},
        method: "POST",
        headerValue: `Bearer ${token}`
      })
      setDeletedUser('null')
    } catch (error) {
      // console.log(error.response)
    }
  
}
  return <>
    {/* user id */}
    <td style={{ 
      color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)"}}>{user_id}</td> 

    {/* <td style={{ 
      color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)"}}>{
          profile_pic_url === "no image" ? <img className="profile-pic" src="/images/user (1).png" alt="pic"/> : "hello"}
    </td>  */}

    {/* username */}
    <td style={{ 
      color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)"}}>{username}</td>

    {/* email */}
    <div className="email-button-row">
      <td style={{color : deletedUser === "null" ? "var(--darkGrey)" : "var(--red)"}}>{email}</td>

      {deletedUser !== "null" ?
        <img className="arrow" src="images/refresh.png" alt="arrow" onClick={() => handle_restore_user(email)} /> : null}

      {deletedUser === "null" ? 
        <img className="trash" src="images/trash.png" alt="trash" onClick={() => handle_delete_user(email)} /> : null}
    </div>
  </>
}

export default UserData

