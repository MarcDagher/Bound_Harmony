import { useEffect, useState } from "react"
import HandleUsersCard from "../../components/UserData/UserData"
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
      get_all_users().then((value) => setListOfUsers(value.data.users))
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
        {listOfUsers &&
        Object.entries(listOfUsers).map((user) => (

          <div key={user.id} className='user-data-cards'>
            {<HandleUsersCard  
                username={user[1]['username']}
                user_id={user[1]['id']}
                email={user[1]['email']}
                deletad_at={user[1]['deleted_at'] ?? 'null'}
                buttonText="Delete"
                boxTitle="Delete User's Account"/>
            }
              
          </div>
        ))}

    </div>
  </div>
  </>
}

export default Users