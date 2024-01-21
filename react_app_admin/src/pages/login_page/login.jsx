import { useState } from "react"
import send_request from "../../configurations/request_function"
import "./login.css"
const Login = () => {

const [formData, setFormData] = useState({
  email : "",
  password : ""
})

const handle_change = (name, value) => {
  setFormData((previous) =>  { return { ...previous, [name] : value}})
}

const handle_submit = async (email, password) => {
  console.log("in button")
  const response = await send_request({

    route: "/login",
    body: {
      'email' : email,
      'password' : password
    },
    method: "POST"

  })
  
  console.log(response)
}
  


  return <>
  <div className="wrapper">

    <div className="container">

        <div className="box-container">
          <p>Welcome Back</p>
          <div className="input-container">
            <input type="text" name="email" id="email" placeholder="email" onChange={(e) => handle_change("email", e.target.value)}/>
            <input type="password" name="password" id="password" placeholder="password" onChange={(e) => handle_change("password", e.target.value)}/>
          </div>
          <button type="button" onClick={ () => handle_submit(formData['email'], formData['password']) }>Log In</button>
        </div>

        <div className="image-container-box">
          <img src="../../../public/Logo2.png" alt="img" />
          <div className="image-container">
            <p>Bound Harmony</p>
          </div>
        </div>

    </div>

  </div>
  </>
}

export default Login