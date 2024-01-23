import { useEffect, useState } from "react"
import UserData from "../../components/UserData/UserData"
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

  return <>
  <div className="users-wrapper">
    {<SideBar />}
    <div className='admin-table-container'>
        <p>Users</p>
        <table>
          <tr>
            <th>ID</th>
            {/* <th>Profile Image</th> */}
            <th>Name</th>
            <th>Email</th>
          </tr>

          {listOfUsers &&
          Object.entries(listOfUsers).map((user) => (
            <tr key={user.id}>
              {<UserData  
                  username={user[1]['username']}
                  user_id={user[1]['id']}
                  email={user[1]['email']}
                  deleted_at={user[1]['deleted_at'] ?? 'null'}
                  profile_pic_url={user[1]['profile_pic_url']}
                  />
              }

            </tr>
          ))}
        </table>

    </div>
  </div>
  </>
}

export default Users