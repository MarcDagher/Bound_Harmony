import { useState } from "react"
import send_request from "../../configurations/request_function"
import "./login.css"
import { useNavigate } from "react-router-dom"
const Login = () => {

const [formData, setFormData] = useState({
  email : "",
  password : ""
})
const [errorMessage, setErrorMessage] = useState('')
const [successMessage, setSuccessMessage] = useState('')
const navigate = useNavigate()

const handle_change = (name, value) => {
  setFormData((previous) =>  { return { ...previous, [name] : value}})
}

const handle_submit = async (email, password) => {
  
  if (formData['password'] === "" || formData['email'] === "") {
    setErrorMessage('All fields are required')
    setSuccessMessage('')
  } else {
    try {
      const response = await send_request({
        route: "/signin",
        body: {
          'email' : email,
          'password' : password
        },
        method: "POST"
      })
      setErrorMessage('')
      setSuccessMessage('Success')
      localStorage.setItem('token', response.data['token'])
      navigate('/dashboard')
    } catch (error) {
      setSuccessMessage('')
      setErrorMessage('Wrong credentials')
      // console.log(`error in handle_submit ${error}`)
    }
  }

}

  return <>
  <div className="wrapper">
        <div className="box-container">
          <div className="logo-title">
            <img className="logo-img" src="images/Logo2.png" alt="img" />
            <p>Welcome Back</p>
          </div>
          <div className="input-container">
            <input type="text" name="email" id="email" placeholder="Email" onChange={(e) => {handle_change("email", e.target.value)}}/>
            <input type="password" name="password" id="password" placeholder="Password" onChange={(e) => {handle_change("password", e.target.value)}}/>
            {errorMessage !== "" ? <p className="error_message">{errorMessage}</p>  : null}
            {successMessage !== "" ? <p className="error_message">{successMessage}</p>  : null}
          </div>
          <button type="button" onClick={ () => handle_submit(formData['email'], formData['password']) }>Log In</button>
        </div>
  </div>
  </>
}

export default Login