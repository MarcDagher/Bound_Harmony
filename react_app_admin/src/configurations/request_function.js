import axios from "axios";


// axios.defaults.baseURL = "http://192.168.1.66:8000/api";
const send_request = async ({route, method = "GET", body}) => {
  try {

      const response = axios.request( {
        url: `http://192.168.1.66:8000/api${route}`,
        method: method,
        data: body,
        headers: {"Content-Type" : "application/json"}
      } );
      return response;    

  } catch (error) {
    console.log(error);
  }
}

export default send_request;