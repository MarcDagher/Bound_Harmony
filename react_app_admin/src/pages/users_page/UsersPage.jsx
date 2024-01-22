import HandleUsersCard from "../../components/HandleUserCard/HandleUserCard"
import "./UsersPage.css"
const Users = () => {

  return <>
  <div className='admin-handle-user-cards'>

    <div className='delete-user'>
        {HandleUsersCard({
          buttonText: "Delete User",
          boxTitle: "Enter User's Email",
          })}
    </div>

    <div className='restore-user'>
        {HandleUsersCard({
          buttonText: "Restore User",
          boxTitle: "Enter User's Email"
          })}
    </div>

  </div>
  </>
}

export default Users