import axios from 'axios';

const api = axios.create({
  baseURL: 'https://api.instagram.com',
});

export const getUserProfile = async (accessToken) => {
  try {
    const response = await api.get('/me', {
      params: {
        access_token: accessToken,
      },
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching user profile', error);
  }
};

