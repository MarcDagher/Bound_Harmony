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
  
  try {
    const response = await send_request({
      route: "/login",
      body: {
        'email' : email,
        'password' : password
      },
      method: "POST"
    })

    if (formData['email'] !== "admin123@hotmail.com"){
      setSuccessMessage('')
      setErrorMessage('Invalid Entry')
    } else {
      setErrorMessage('')
      setSuccessMessage('success')
      localStorage.setItem('token', response.data['authorisation']['token'])
      localStorage.setItem('user_data', response.data['user'])
      navigate('/admin')
    }
    
    // console.log(response)
    
  } catch (error) {
    setSuccessMessage('')
    if (formData['password'] === "" || formData['email'] === "") {
      setErrorMessage('All fields are required')
    } else {
      setErrorMessage('Wrong credentials')
    }
    console.log(`error in handle_submit ${error}`)
  }
}

  return <>
  <div className="wrapper">

    <div className="container">

        <div className="box-container">
          <p>Welcome Back</p>
          <div className="input-container">
            <input type="text" name="email" id="email" placeholder="email" onChange={(e) => {handle_change("email", e.target.value)}}/>
            <input type="password" name="password" id="password" placeholder="password" onChange={(e) => {handle_change("password", e.target.value)}}/>
            {errorMessage !== "" ? <p className="error_message">{errorMessage}</p>  : null}
            {successMessage !== "" ? <p className="error_message">{successMessage}</p>  : null}
          </div>
          <button type="button" onClick={ () => handle_submit(formData['email'], formData['password']) }>Log In</button>
        </div>

        <div className="image-container-box">
          <img src="/Logo2.png" alt="img" />
          <div className="image-container">
            <p>Bound Harmony</p>
          </div>
        </div>

    </div>

  </div>
  </>
}

export default Login