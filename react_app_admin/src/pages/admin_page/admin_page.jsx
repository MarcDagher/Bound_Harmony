import { useEffect, useState } from 'react';
import axios from 'axios';
import './admin_page.css';
import send_request from "../../configurations/request_function";
const Admin = () => {


  const handle_request = async () => {
    const response = await send_request({
      route: "/users_age_range",
      method: "GET",
      body: ""
    }).then().catch()

    console.log(response)
    return response
  }

  return <>
    <p>Hello</p>
  </>
}

export default Admin;