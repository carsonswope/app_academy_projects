CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password_digest VARCHAR(255) NOT NULL,
  session_token VARCHAR(255) NOT NULL
);
