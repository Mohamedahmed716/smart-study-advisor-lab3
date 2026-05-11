import axios from 'axios';

const IP_ADDRESS = '192.168.1.20'; 
const BASE_URL = `http://${IP_ADDRESS}:8000/api`;

export const fetchCourseRecommendations = async (payload) => {
  try {
    const response = await axios.post(`${BASE_URL}/recommend/`, payload);
    return response.data;
  } catch (error) {
    throw new Error(error.response?.data?.message || "Failed to connect to backend");
  }
};