import "./HandleUserCard.css"

const HandleUsersCard = ({buttonText, boxTitle}) => {

  return <>
    <div className="admin-box-container">
            <p>{boxTitle}</p>
            <div className="admin-input-container">
              <input type="text" name="email" id="email" placeholder="email" />
              {/* {errorMessage !== "" ? <p className="error_message">{errorMessage}</p>  : null} */}
              {/* {successMessage !== "" ? <p className="error_message">{successMessage}</p>  : null} */}
            </div>
            <button type="button" >{buttonText}</button>
    </div>
  </>
}

export default HandleUsersCard