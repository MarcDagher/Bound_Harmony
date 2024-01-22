import { useState } from "react"
import "./HandleUserCard.css"

const HandleUsersCard = ({buttonText, boxTitle, handle_submit}) => {

  const [formEmail, setFormEmail] = useState("")

  const handle_change = (value) => {
    setFormEmail(value)
  }
  // console.log(formEmail)

  return <>
    <div className="admin-box-container">
            <p>{boxTitle}</p>
            <div className="admin-input-container">
              <input type="text" name="email" id="email" placeholder="email" onChange={(e) => handle_change(e.target.value)} />
              {/* {errorMessage !== "" ? <p className="error_message">{errorMessage}</p>  : null} */}
              {/* {successMessage !== "" ? <p className="error_message">{successMessage}</p>  : null} */}
            </div>
            <button type="button" onClick={() => handle_submit({email: formEmail})}>{buttonText}</button>
    </div>
  </>
}

export default HandleUsersCard