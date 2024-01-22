import { useEffect, useState } from "react"
import HandleUsersCard from "../../components/HandleUserCard/HandleUserCard"
import SideBar from "../../components/SideBar/SideBar"
import "./UsersPage.css"
import send_request from "../../configurations/request_function"
const Users = () => {

  const [listOfUsers, setListOfUsers] = useState()
  
  const token = localStorage.getItem('token')
  const get_all_users = async () => {
    const response = send_request({
      body:{},
      route: '/get_all_users',
      method: 'GET',
      headerValue: `Bearer ${token}`
    }) 
    return response
  } 

  useEffect(() => {
    try {
      get_all_users().then((value) => setListOfUsers(value))
    } catch (error) {
      console.log(error)
    }
  },[])

  console.log(listOfUsers)

  return <>
  <div className="users-wrapper">
    {<SideBar />}
    <div className='admin-handle-user-cards'>
        <p>Users</p>
      <div className='delete-user'>
          {HandleUsersCard({
            buttonText: "Delete",
            boxTitle: "Delete User's Account",
            })}
      </div>

      <div className='restore-user'>
          {HandleUsersCard({
            buttonText: "Restore",
            boxTitle: "Restore User's Account"
            })}
      </div>

    </div>
  </div>
  </>
}

export default Users