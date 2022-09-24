import { config } from 'dotenv';
import { readFileSync } from 'fs';

config();
export default () => {
  return {
    security: {
      secret: process.env.APP_SECRET || ''
    },
    port    : parseInt(process.env.PORT, 10) || 3000,
    database: {
      host    : process.env.DB_HOST,
      port    : Number(process.env.DB_PORT),
      username: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: process.env.DB_NAME,
    },
    mongo_url: process.env.MONGO_URL || '',
  };
};
