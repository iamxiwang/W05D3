

DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

INSERT INTO
  users(fname, lname)
Values
  ('Bikramjit', 'Singh'),
  ('xi', 'wang');


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);




INSERT INTO
  questions (title, body, author_id)
Values
  ('tuition?', 'financial', (SELECT id FROM users WHERE fname = 'Bikramjit' AND lname = 'Singh')),
  ('job', 'how long to get a job', (SELECT id FROM users WHERE fname = 'xi' AND lname = 'wang'));



CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER,
    users_id INTEGER
);

INSERT INTO
  question_follows(question_id, users_id)
Values
  ((SELECT id FROM questions WHERE title = 'tuition?'), (SELECT id FROM users WHERE fname = 'Bikramjit' AND lname = 'Singh')),
  ((SELECT id FROM questions WHERE title = 'job'), (SELECT id FROM users WHERE fname = 'xi' AND lname = 'wang'));


CREATE TABLE replies (
id INTEGER PRIMARY KEY,
question_id INTEGER NOT NULL,
parent_id INTEGER,
author_id INTEGER NOT NULL,
body TEXT NOT NULL,
FOREIGN KEY (author_id) REFERENCES users(id),
FOREIGN KEY (parent_id) REFERENCES replies(id)

);

INSERT INTO
  replies (question_id, parent_id, author_id, body)
Values
    ((select id from questions where title = 'tuition?'), NULL, (select id from users where fname = 'xi' and lname = 'wang'), 'xi xi xi');

INSERT INTO
  replies (question_id, parent_id, author_id, body)
Values
    ((select id from questions where title = 'tuition?'), (select id from replies where body = 'xi xi xi'), (select id from users where fname = 'xi' and lname = 'wang'), 'bik bik bik');
    
CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)

);

INSERT INTO
  question_likes(user_id, question_id)
Values
  ((SELECT id FROM users WHERE fname = 'xi' AND lname = 'wang'), (SELECT id FROM questions WHERE title = 'tuition?')),
  ((SELECT id FROM users WHERE fname = 'Bikramjit' AND lname = 'Singh'), (SELECT id FROM questions WHERE title = 'job'));



        






