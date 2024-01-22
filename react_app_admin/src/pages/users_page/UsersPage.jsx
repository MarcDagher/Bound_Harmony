import HandleUsersCard from "../../components/HandleUserCard/HandleUserCard"
import SideBar from "../../components/SideBar/SideBar"
import "./UsersPage.css"
const Users = () => {

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