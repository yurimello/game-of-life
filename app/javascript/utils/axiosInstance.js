// src/utils/axiosInstance.js

import axios from 'axios';
import { getCsrfToken } from './csrfToken';

const axiosInstance = axios.create({
  baseURL: '/api',
  headers: {
    'X-CSRF-Token': getCsrfToken(),
    'Content-Type': 'application/json',
  }
});

export default axiosInstance;