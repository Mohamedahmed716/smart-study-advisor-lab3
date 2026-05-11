import axios from 'axios';

// Pulls the URL from the local un-tracked .env file
const BASE_URL = process.env.EXPO_PUBLIC_API_URL;

export const fetchCourseRecommendations = async (payload) => {
  if (!BASE_URL) {
    throw new Error("Missing EXPO_PUBLIC_API_URL in .env file");
  }

  try {
    const response = await axios.post(`${BASE_URL}/recommend/`, payload);
    return response.data;
  } catch (error) {
    throw new Error(error.response?.data?.message || "Failed to connect to backend");
  }
};