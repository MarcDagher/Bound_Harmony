import "./login.css"
const Login = () => {


  return <>
  <div className="wrapper">

    <div className="container">

        <div className="box-container">
          <p>Log In</p>
          <div className="input-container">
            <input type="text" name="email" id="email" placeholder="email"/>
            <input type="password" name="password" id="password" placeholder="password"/>
          </div>
          <button type="button">Log In</button>
        </div>

        <div className="image-container-box">
          <img src="../.././public/Logo 2.png" alt="img" />
          <div className="image-container">
            <p>Bound Harmony</p>
          </div>
        </div>

    </div>

  </div>
  </>
}

export default Login