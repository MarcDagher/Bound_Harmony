import "./SideBar.css" 
const SideBar = () => {

  return <>
      <div className='admin-sidebar'>
        <div className="dashboard">
            <span>Dashboard</span>
        </div>
        <div className="users">
            <span>Users</span>
        </div>
        <div className="survey-responses">
            <span>Survey Responses</span>
        </div>
    </div>
  </>
}

export default SideBar